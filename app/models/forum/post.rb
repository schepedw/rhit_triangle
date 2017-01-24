module Forum
  class Post < ActiveRecord::Base
    include TimeFormatHelper

    validates  :content, :author_id, :channel_id, presence: true
    belongs_to :author, class_name: 'Member'
    belongs_to :channel
    belongs_to :parent, class_name: 'Forum::Post'
    has_many   :replies, class_name: 'Forum::Post', foreign_key: 'parent_id'
    has_many   :reactions
    has_many   :notifications
    after_commit :create_notification
    around_update :update_notifications
    after_destroy :acknowledge_notifications

    def formatted_updated_at # rubocop:disable Metrics/AbcSize
      # TODO: this is poorly implemented and mislocated and.. I'm feeling lazy
      if updated_at.to_date == Time.zone.today
        updated_at.localtime.strftime(clock_time_format)
      elsif updated_at.to_date > Time.zone.today - 7.days
        updated_at.localtime.strftime(this_week_format)
      elsif updated_at.year > Time.zone.today.year
        updated_at.localtime.strftime(this_year_format)
      else
        updated_at.localtime.strftime(legible_timestamp_format)
      end
    end

    def tagged_members(c = content)
      matches = c.scan(/(?:^| )@([\w.]*)/).flatten
      return [] unless matches.present?
      screen_names = matches.map { |name| name.strip.chomp('.') }
      Member.where(screen_name: screen_names)
    end

    private

    def notification_recipients(c = content)
      return tagged_members(c) if tagged_members(c).empty?
      tagged_members(c).where.not(member_id: author_id)
    end

    def create_notification
      ForumNotificationWorker.perform_async(id, notification_recipients.map(&:member_id))
    end

    def update_notifications
      previous_notification_recipients = notification_recipients(changes['content'][0]).map(&:member_id)
      yield
      new_notification_recipients = notification_recipients.map(&:member_id)
      added_tags = new_notification_recipients - previous_notification_recipients
      removed_tags = previous_notification_recipients - new_notification_recipients
      notifications.where(recipient_id: removed_tags).update_all(acknowledged: true)
      ForumNotificationWorker.perform_async(id, added_tags)
    end

    def acknowledge_notifications
      notifications.update_all(acknowledged: true)
    end
  end
end
