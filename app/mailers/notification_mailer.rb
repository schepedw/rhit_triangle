class NotificationMailer < ActionMailer::Base
  def email_notice(notification)
    @notification = notification
    mail_attributes = {
      to: @notification.recipient.email,
      from: 'rose.triangle@gmail.com',
      subject: 'Missed Notification in the Triangle Forum'
    }
    mail(mail_attributes) do |format|
      format.text
      format.html
    end
  end
end
