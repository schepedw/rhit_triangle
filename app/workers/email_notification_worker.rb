class EmailNotificationWorker
  include Sidekiq::Worker

  def perform(notification_ids)
    notification_ids.each do |id|
      notification = Notification.includes(:notifier, :recipient, post: :channel).find(id)
      next if notification.acknowledged?
      mail = email_notification(notification)
      notification.update(acknowledged: true)
      Message.create!(to_id: notification.recipient_id, from_id: notification.notifier_id, direction: 'outgoing',
                      subject: mail.subject, content: mail.body)
    end
  end

  private

  def email_notification(notification)
    NotificationMailer.email_notice(notification).tap(&:deliver_now!)
  end
end
