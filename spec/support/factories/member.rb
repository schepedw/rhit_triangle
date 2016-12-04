FactoryGirl.define do
  factory :member do
    email { Faker::Internet.email }
    password Faker::Internet.password
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    confirmed_at Time.zone.now
  end
end
