class Notification < ActiveRecord::Base
  has_one :message, primary_key: :message_id
  belongs_to :recipient, class_name: 'Member', foreign_key: 'recipient_id'
  belongs_to :notifier, class_name: 'Member', foreign_key: 'notifier_id'
  belongs_to :post, class_name: 'Forum::Post', foreign_key: 'post_id'
  scope :unacknowledged, -> { where(acknowledged: false) }

  def to_s
    "#{notifier.full_name} mentioned you in #{post.channel.subject}"
  end

  def url
    "/forum/channels/#{post.channel_id}"
  end
end
