$(function(){
  $('[data-action=donation_summary]').click(function(){
    table = $($(this).data('target')).find('table')
    table.DataTable({
      'ajax': '/projects/' + table.data('id') + '/donations.json',
      'columns': [
        { data: 'donor_name' },
        { data: 'recurring_amount' },
        { data: 'frequency' },
        { data: 'project_id' }//this needs to be total_to_date
      ],
      "bFilter": false //#TODO: css this correctly & reenable it
    });
    table.css('margin-left', '0px');
  })
});
