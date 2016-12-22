FactoryGirl.define do
  factory :post, class: Forum::Post do
    content { Faker::Lorem.paragraph }
    depth 0

    before(:create) do |post|
      post.author_id  ||= create(:member).id
      post.channel_id ||= create(:channel).id
    end
  end
end
