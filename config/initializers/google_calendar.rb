require 'google/apis/calendar_v3'
require 'googleauth'

Gcal = Google::Apis::CalendarV3::CalendarService.new
json_key_io = File.open('./service_account_creds.json')
Gcal.authorization =
  Google::Auth::ServiceAccountCredentials.make_creds({scope: Google::Apis::CalendarV3::AUTH_CALENDAR, json_key_io: json_key_io})
