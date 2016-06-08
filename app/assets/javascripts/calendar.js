// Start
current_date = new Date();
displayed_date = new Date();
$(function(){
  populateCalendar(current_date);

  $('.calendar-scroll.pull-left').click(function(){
    displayed_date.setMonth(displayed_date.getMonth() - 1);
    populateCalendar(displayed_date);
  });

  $('.calendar-scroll.pull-right').click(function(){
    displayed_date.setMonth(displayed_date.getMonth() + 1);
    populateCalendar(displayed_date);
  });

  /*
     $('.days_cal td').click(function(){
     $('td.active').removeClass('active');
     $(this).addClass('active');
     });
     */

});

function calendar(date) {
  resetToday();

  var cal = new Date(date);

  // vars
  var day_of_week = new Array(
    'SUN', 'MON', 'TUE',
    'WED', 'THU', 'FRI', 'SAT'),
    month_of_year = new Array(
      'JANUARY', 'FEBRUARY', 'MARCH',
      'APRIL', 'MAY', 'JUNE', 'JULY',
      'AUGUST', 'SEPTEMBER', 'OCTOBER',
      'NOVEMBER', 'DECEMBER'),

      year = cal.getYear(),
      month = cal.getMonth(),
      today = current_date.getDate(),
      this_month = current_date.getMonth(),
      weekday = cal.getDay(),
      zero_padded_month = ('0' + (cal.getMonth() + 1)).slice(-2),
      info = cal.getFullYear()  + '-' + zero_padded_month + '-' + ('0' + today).slice(-2),
      html = '';
      retrieveInfo(info)

      // start in 1 and this month
      cal.setDate(1);
      cal.setMonth(month);

      // template calendar
      $('#calendar_header .month').text(month_of_year[month]);
      $('#calendar_header .year').text(cal.getFullYear());
      html = '<table>';
      // head
      html += '<thead>';
      html += '<tr class="week_cal">';
      for (index = 0; index < 7; index++) {
        html += '<th>' + day_of_week[index] + '</th>';
      }
      html += '</tr>';
      html += '</thead>';

      // body
      html += '<tbody class="days_cal">';
      html += '</tr>';
      // white zone
      for (index = 0; index < cal.getDay(); index++) {
        html += '<td class="white_cal"> </td>';
      }

      for (index = 0; index < 31; index++) {
        if (cal.getDate() > index) {

          week_day = cal.getDay();

          if (week_day === 0) {
            html += '</tr>';
          }
          if (week_day !== 7) {
            // this day
            day = cal.getDate();
            zero_padded_month = ('0' + (cal.getMonth() + 1)).slice(-2)
            info = cal.getFullYear()  + '-' + zero_padded_month + '-' + ('0' + day).slice(-2);
            if (day < 10){
              singleDigit = 'single-digit '
            } else{
              singleDigit = ' '
            }
            if (day == today && this_month == month){
              html += '<td class="active"><a href="javascript:void(0);" class="' + singleDigit +  '" data-id="' + info + '">' +
                day + '</a></td>';
            }
            else{
              html += '<td><a href="javascript:void(0);"; class="' + singleDigit +   '" data-id="' + info + '">' +
                day + '</a></td>';
            }

          }
          if (week_day == 7) {
            html += '</tr>';
          }
        }
        cal.setDate(cal.getDate() + 1);
      } // end for loop
      return html;
}

function setDateListeners(){
  $('.days_cal td').click(function(){
    $('td.active').removeClass('active');
    $(this).addClass('active');
    retrieveInfo($(this).find('a').data('id'));
  });
}

function retrieveInfo(date) {
  fields = ['id', 'start', 'summary', 'location', 'description']
  start = new Date(date);
  end = new Date(date);
  end.setUTCHours(23, 59, 59, 999); // TODO: this isn't entirely correct. Triangle events are presumably in EST (UTC - 4)
  data = { start_time: start.toISOString(), end_time: end.toISOString(), fields: fields }
  $('#calendar_data .event-date').text(formatDate(date));
  $.ajax({url: 'calendar/events.json', data: data, success: populate_event_detail});
}

function populate_event_detail(json_response) {
  if(json_response.length == 0) {
    no_event_info();
    return;
  }
  //TODO: what happens when we have multiple events on a day?
  event = json_response[0]
  $('#calendar_data .event-title').text(event.summary);
  event_info = event.description || 'No description available for this event'
  $('#calendar_data .event-info').text(event_info);
  //TODO: Populate start time, if it exists
  //TODO: Populate location, if it exists
}

function no_event_info(){
  $('#calendar_data .event-title').text('No events today');
  $('#calendar_data .event-info').text("There's nothing on the calendar for today. Take a look at the calendar to find when" +
                        " our next event is");
}

function populate_event_days(json_response){
  for (var i = 0; i < json_response.length; i++){
    event = json_response[i]
    date = (event.start.date || event.start.date_time).substring(0,10);
    calendar_entry = $('[data-id="' + date + '"]')
    calendar_entry.addClass('has-event');
    calendar_entry.parent().append('<br /><span class="event-marker">•</span>')
  }
}

function resetToday(){
  $('.today').removeClass('today');
}

function formatDate(date){
  // TODO: hack
  // TODO: make these ordinal numbers
  return $.datepicker.formatDate("M d, yy", new Date(date + 'GMT-500'));
}

function monthBeginning(date){
  return new Date(date.getFullYear(), date.getMonth(), 1);
}

function monthEnd(date){
  return new Date(date.getFullYear(), date.getMonth() + 1, 0);
}

function populateCalendar(date){
  $('#calendar').html(calendar(date));
  setDateListeners();
  data = {
    fields: ['id', 'start'],
    start_time: monthBeginning(displayed_date).toISOString(),
    end_time: monthEnd(displayed_date).toISOString()
  }
  $.ajax({url: 'calendar/events.json', data: data, success: populate_event_days});
}
