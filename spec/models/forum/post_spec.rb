require 'rails_helper'

describe Forum::Post do
  subject { create(:post, content: content, author_id: author.id) }
  let(:author) { create(:member) }

  describe '#tagged_members' do
    shared_examples 'no tagged members' do
      it 'returns an empty array' do
        expect(subject.tagged_members).to be_empty
      end
    end

    context 'no matches present' do
      let(:content) { 'I like turtles' }
      it_behaves_like 'no tagged members'
    end

    context 'no members with the given screen name' do
      let(:content) { '@guy_not_goan.be_here whats up' }
      it_behaves_like 'no tagged members'
    end

    context 'correctly finding tagged members' do
      let(:recipient) { create(:member) }
      let(:content) { "@#{recipient.reload.screen_name}" }
      it 'returns the list of tagged members' do
        expect(subject.tagged_members.size).to eq 1
        expect(subject.tagged_members).to include(recipient)
      end
    end
  end

  context 'callbacks' do
    let(:content) { '@' + tagged_members.map(&:screen_name).join(', @') }
    let(:recipient) { create(:member) }
    let(:tagged_members) { [author.reload, recipient.reload] }

    describe '#create_notification' do
      it 'queues jobs to create notifications' do
        expect(ForumNotificationWorker).to receive(:perform_async).with(subject.id, [tagged_members.last.id])
        subject.run_callbacks(:commit)
      end
    end

    describe '#update_notifications' do
      it 'acknowledges all previous notifications' do
        subject.update(content: 'lol')
        expect(Notification.where(recipient_id: recipient.id).all?(&:acknowledged?)).to be true
      end

      it 'creates notifications for newly tagged mambers' do
        new_recipient = create(:member).reload
        expect(ForumNotificationWorker).to receive(:perform_async).with(subject.id, [new_recipient.id])
        subject.update(content: "hi @#{new_recipient.screen_name}")
      end
    end
  end
end
