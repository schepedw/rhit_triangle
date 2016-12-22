FactoryGirl.define do
  factory :channel, class: Forum::Channel do
    subject { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
