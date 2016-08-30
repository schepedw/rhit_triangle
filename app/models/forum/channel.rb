module Forum
  class Channel < ActiveRecord::Base
    has_many :posts
    has_and_belongs_to_many :members, join_table: 'channel_members'
  end
end
