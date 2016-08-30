module Forum
  class Post < ActiveRecord::Base
    belongs_to :author, class_name: 'Member'
    belongs_to :channel
    belongs_to :parent, class_name: 'Forum::Post'
    has_many   :replies, class_name: 'Forum::Post', foreign_key: 'parent_id'
  end
end
