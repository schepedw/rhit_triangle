FactoryGirl.define do
  factory :reaction, class: Forum::Reaction do
    reaction_text 'Like'

    before(:create) do |reaction|
      reaction.member_id ||= create(:member).id
      reaction.post_id   ||= create(:post).id
    end
  end
end
