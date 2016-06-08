class RushController < ApplicationController
  include CalendarHelper

  def index
    @events = search_events(today, one_month_from_today, default_event_fields, max_results: 7)

    @questions_and_answers = [
      { question: 'Who`s your favorite Disney character?', answer: Faker::Lorem.paragraph },
      { question: 'Do you like ice cream?', answer: Faker::Lorem.paragraph },
      { question: 'Do you like toads?', answer: Faker::Lorem.paragraph },
      { question: 'Would you describe yourself as easy to talk to, fun to hang out with?',
        answer: Faker::Lorem.paragraph },
      { question: 'Are you a smelly CS?', answer: Faker::Lorem.paragraph }
    ]
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
