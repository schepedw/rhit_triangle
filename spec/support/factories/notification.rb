FactoryGirl.define do
  factory :notification do
    before(:create) do |note|
      note.notifier_id  ||= create(:member).id
      note.recipient_id ||= create(:member).id
      note.post_id ||= create(:post).id
    end
  end
end
