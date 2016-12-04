Before do
  allow(Gcal).to receive(:list_events) { Google::Apis::CalendarV3::Events.new(items: []) }
end
