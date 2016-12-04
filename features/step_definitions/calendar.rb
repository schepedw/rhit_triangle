Given(/^I have an event today$/) do
  start = Google::Apis::CalendarV3::EventDateTime.new(date_time: Time.zone.now)
  @event = Google::Apis::CalendarV3::Event.new(id: 'lol',
                                               location: 'Triangle House',
                                               start: start,
                                               summary: 'Chapter')
  allow(Gcal).to receive(:list_events).with(
    'rose.triangle@gmail.com',
    max_results: 100,
    single_events: true,
    order_by: 'startTime',
    time_min: "#{Time.zone.today}T00:00:00.000-04:00",
    time_max: "#{Time.zone.today}T23:59:59.999-04:00",
    page_token: nil,
    fields: 'items(description,id,location,start,summary),next_page_token'
  ).and_return(
    Google::Apis::CalendarV3::Events.new(items: [@event])
  )

  allow(Gcal).to receive(:list_events).with(
    'rose.triangle@gmail.com',
    max_results: 100,
    single_events: true,
    order_by: 'startTime',
    time_min: "#{Time.zone.today.beginning_of_month}T06:00:00.000-04:00",
    time_max: "#{Time.zone.today.end_of_month}T06:00:00.000-04:00",
    page_token: nil,
    fields: 'items(id,start),next_page_token'
  ).and_return(Google::Apis::CalendarV3::Events.new(items: []))
end

Given(/^I have an event tomorrow$/) do
  Date.include(DateAndTime::Calculations)
  @future_event = Google::Apis::CalendarV3::Event.new(
    id: 'lol',
    location: 'Triangle House',
    start: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.tomorrow.to_datetime),
    summary: 'Chapter'
  )
  allow(Gcal).to receive(:list_events).with(
    'rose.triangle@gmail.com',
    max_results: 100,
    single_events: true,
    order_by: 'startTime',
    time_min: "#{Time.zone.today}T00:00:00.000-04:00",
    time_max: "#{Time.zone.today}T23:59:59.999-04:00",
    page_token: nil,
    fields: 'items(description,id,location,start,summary),next_page_token'
  ).and_return(
    Google::Apis::CalendarV3::Events.new(items: [])
  )

  expect(Gcal).to receive(:list_events).with(
    'rose.triangle@gmail.com',
    max_results: 100,
    single_events: true,
    order_by: 'startTime',
    time_min: a_string_matching(/#{Time.zone.today.beginning_of_month}T0\d:00:00.000-04:00/),
    time_max: a_string_matching(/#{Time.zone.today.end_of_month}T0\d:00:00.000-04:00/),
    page_token: nil,
    fields: 'items(id,start),next_page_token'
  ).and_return(Google::Apis::CalendarV3::Events.new(items: [@future_event]))
end

Then(/^I should see details of today's event$/) do
  wait_for_ajax
  within('#calendar_data') do
    expect(page).to have_content(@event.summary)
  end
end

Then(/^I should see that I have an event tomorrow$/) do
  wait_for_ajax
  expect(find("[data-id='#{Date.tomorrow}']")[:class]).to include 'has-event'
end
