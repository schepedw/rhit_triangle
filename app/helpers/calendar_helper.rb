module CalendarHelper
  def search_events(start_time, end_time, fields, max_results: 100)
    fields ||= %w[id summary start description]
    Gcal.list_events('rose.triangle@gmail.com',
                     max_results: max_results,
                     single_events: true,
                     order_by: 'startTime',
                     time_min: start_time,
                     time_max:  end_time,
                     page_token: nil,
                     fields: "items(#{fields.join(',')}),next_page_token").items
  end

  def permitted_search_fields
    %w[anyone_can_add_self attachments attendees attendees_omitted color_id created creator description end
       end_time_unspecified etag extended_properties gadget guests_can_invite_others guests_can_modify
       guests_can_see_other_guests hangout_link html_link i_cal_uid id kind location locked organizer
       original_start_time private_copy recurrence recurring_event_id reminders sequence source start status
       summary transparency updated visibility]
  end
end
