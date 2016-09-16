module Forum
  class Channel < ActiveRecord::Base
    has_many :posts
    has_and_belongs_to_many :members, join_table: 'channel_members'
    scope :publik, -> { where(visibility: 'public') }

    def self.nil_channel
      new(id: -1)
    end

    def publik?
      visibility == 'public'
    end

    def visible_to?(member)
      publik? ||
        self.class.connection.select_value("SELECT #{member.id} IN (#{members.select(:member_id).to_sql})") == 't'
    end

    def member_count
      # TODO: this is a temporary method, until I figure out what exactly 'joining a channel' looks like
      posts.select(:author_id).uniq.count
    end
  end
end
