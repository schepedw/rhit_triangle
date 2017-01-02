FactoryGirl.define do
  factory :gcal_event, class: Google::Apis::CalendarV3::Event do
    sequence(:id)
    location { Faker::Address.street_address }
    start Google::Apis::CalendarV3::EventDateTime.new(date_time: Time.zone.now)
    summary { Faker::Lorem.paragraph }
    transient do
      start_time nil
    end

    after(:build) do |event, evaluator|
      if evaluator.start_time.present?
        event.start = Google::Apis::CalendarV3::EventDateTime.new(date_time: evaluator.start_time)
      end
    end
  end
end
