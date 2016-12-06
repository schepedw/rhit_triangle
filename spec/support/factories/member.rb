FactoryGirl.define do
  factory :member do
    email { Faker::Internet.email }
    password AppConfig.default_password
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    initiation_year 1992
    confirmed_at Time.zone.now
  end
end
