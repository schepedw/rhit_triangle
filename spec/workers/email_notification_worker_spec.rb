require 'rails_helper'
require 'mail'

Mail.defaults do
  delivery_method :test
end

describe EmailNotificationWorker do
  include Mail::Matchers

  describe '#perform' do
    let(:notification) { create(:notification, acknowledged: acknowledged) }
    let(:acknowledged) { false }
    let(:notification_ids) { [notification.id] }

    shared_examples 'no action taken' do
      it 'does nothing' do
        expect(NotificationMailer).not_to receive(:email_notice)
        expect(Message).not_to receive(:create!)
        subject.perform(notification_ids)
      end
    end

    context 'no notification ids passed' do
      let(:notification_ids) { [] }
      let(:acknowledged) { false }
      it_behaves_like 'no action taken'
    end

    context 'notification acknowledged' do
      let(:notification_ids) { [notification.id] }
      let(:acknowledged) { true }
      it_behaves_like 'no action taken'
    end

    it 'sends an email' do
      subject.perform(notification_ids)
      expect(Mail).to have_sent_email.to(notification.recipient.email)
    end

    it 'saves record of the sent email' do
      expect { subject.perform(notification_ids) }.to change { Message.count }.by(1)
    end
  end
end
