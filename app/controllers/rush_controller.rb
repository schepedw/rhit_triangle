class RushController < ApplicationController
  include CalendarHelper

  def index
    @events = search_events(today, one_month_from_today, default_event_fields, max_results: 7)
    @questions_and_answers = AppConfig.q_and_a
  end

  private

  def today
    Time.new.iso8601
  end

  def one_month_from_today
    (Time.zone.now + 1.month).to_time.iso8601
  end

  def default_event_fields
    %w[id summary location start description]
  end
end
