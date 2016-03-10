// Start
current_date = new Date();
displayed_date = new Date();
$(function(){
  $('#calendar').html(calendar(current_date));


  $('.calendar-scroll.pull-left').click(function(){
    displayed_date.setMonth(displayed_date.getMonth() - 1);
    $('#calendar').html(calendar(displayed_date));
  });
  $('.calendar-scroll.pull-right').click(function(){
    displayed_date.setMonth(displayed_date.getMonth() + 1);
    $('#calendar').html(calendar(displayed_date));
  });
});

function calendar(date) {
  // show info on init
  showInfo();
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
      html = '';

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
            var day = cal.getDate();
            var info = (cal.getMonth() + 1) + '/' + day + '/' + cal.getFullYear();

            if (index == today - 1 && this_month == month){
              html += '<td class="today"><a href="#" data-id="' + info + '" onclick="showInfo(\'' + info + '\')">' +
                day + '</a></td>';
            }
            else{
              html += '<td><a href="#" data-id="' + info + '" onclick="showInfo(\'' + info + '\')">' +
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
// short queySelector
function _(s) {
  return document.querySelector(s);
};

// show info
function showInfo(event) {
}

function resetToday(){
  $('.today').removeClass('today');
}

// simple calendar
