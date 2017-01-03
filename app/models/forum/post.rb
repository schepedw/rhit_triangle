module Forum
  class Post < ActiveRecord::Base
    include TimeFormatHelper

    validates  :content, :author_id, :channel_id, presence: true
    belongs_to :author, class_name: 'Member'
    belongs_to :channel
    belongs_to :parent, class_name: 'Forum::Post'
    has_many   :replies, class_name: 'Forum::Post', foreign_key: 'parent_id'
    has_many   :reactions

    def formatted_updated_at # rubocop:disable Metrics/AbcSize
      # TODO: this is poorly implemented and mislocated and.. I'm feeling lazy
      if updated_at.to_date == Time.zone.today
        updated_at.strftime(clock_time_format)
      elsif updated_at.to_date > Time.zone.today - 7.days
        updated_at.strftime(this_week_format)
      elsif updated_at.year > Time.zone.today.year
        updated_at.strftime(this_year_format)
      else
        updated_at.strftime(legible_timestamp_format)
      end
    end

    def tagged_members
      screen_names = content.match(/(?:^| )@([\w.]*)/).captures.map{|name| name.chomp('.').strip }
      Member.where(screen_name: screen_names)
    end
  end
end
