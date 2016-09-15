module Forum
  class Post < ActiveRecord::Base
    include TimeFormatHelper

    validates  :content, :author_id, :channel_id, presence: true
    belongs_to :author, class_name: 'Member'
    belongs_to :channel
    belongs_to :parent, class_name: 'Forum::Post'
    has_many   :replies, class_name: 'Forum::Post', foreign_key: 'parent_id'
    has_many   :reactions

    def formatted_created_at # rubocop:disable Metrics/AbcSize
      if created_at.to_date == Time.zone.today
        created_at.strftime(clock_time_format)
      elsif created_at.to_date > Time.zone.today - 7.days
        created_at.strftime(this_week_format)
      elsif created_at.year > Time.zone.today.year
        created_at.strftime(this_year_format)
      else
        created_at.strftime(legible_timestamp_format)
      end
    end
  end
end
