class MemberInfoMailer < ActionMailer::Base
  def email_info(recipient_email)
    @member = Member.find_by_email(recipient_email)
    return unless @member.present?
    mail_attributes = { to: recipient_email, from: 'rose.triangle@gmail.com', subject: 'Your Triangle Login Info' }

    mail(mail_attributes) do |format|
      format.text
      format.html
    end
  end
end
