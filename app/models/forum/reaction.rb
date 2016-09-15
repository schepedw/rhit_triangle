module Forum
  class Reaction < ActiveRecord::Base
    validates :reaction_text, :member_id, :post_id, presence: true
    belongs_to :member
    belongs_to :post
  end
end
