class Calendar::EventsController < ApplicationController
  include CalendarHelper
  def index
    respond_to do |format|
      format.html
      format.json do
        render json: search_events(start_time, end_time, search_fields)
      end
    end
  rescue Google::Apis::TransmissionError, Hurley::Timeout
    render json: { error: 'Cannot connect to Google Calendar' }, status: 500
  end

  private

  def start_time
    params[:start_time] || Time.new.beginning_of_month.iso8601
  end

  def end_time
    params[:end_time] || Time.new.end_of_month.iso8601
  end

  def search_fields
    return unless params[:fields].present?
    permitted_search_fields & params[:fields]
  end
end
