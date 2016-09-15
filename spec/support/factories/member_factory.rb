FactoryGirl.define do
  factory :member do
    first_name Faker::Name.first_name
    middle_name Faker::Name.first_name
    last_name Faker::Name.last_name
    hometown Faker::Address.city
    graduation_year { rand(1951...Time.zone.today.year) }
    initiation_year { rand(1951...Time.zone.today.year) }
    email Faker::Internet.email
    password Faker::Internet.password
  end
end
