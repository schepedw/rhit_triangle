require 'rails_helper'

describe ForumNotificationWorker do
  describe '#perform' do
    let(:post) { create(:post, author_id: posting_member.id) }
    let(:posting_member) { create(:member) }
    let(:tagged_member) { create(:member) }

    shared_examples 'no action taken' do
      it 'does nothing' do
        expect { subject.perform(post.id, tagged_member_ids) }.to change { Notification.count }.by(0)
      end
    end

    context 'no tagged members' do
      let(:tagged_member_ids) { [] }
      it_behaves_like 'no action taken'
    end

    context 'tagged member is the posting member' do
      let(:tagged_member_ids) { [posting_member.id] }
      it_behaves_like 'no action taken'
    end

    it 'creates a notification for the tagged member' do
      expect { subject.perform(post.id, [tagged_member.id]) }.to change { Notification.count }.by(1)
    end

    it 'queues an email notification' do
      expect(EmailNotificationWorker).to receive(:perform_in)
      subject.perform(post.id, [tagged_member.id])
    end
  end
end
