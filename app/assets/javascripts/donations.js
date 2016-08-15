$(function(){
  $('.project-slider').each(function(){
    progress = $(this).find('.capital-progress');
    totalCost = $(this).find('.total-cost');
    $(this).find('#project-slider').slider({
      value: parseInt(progress.html().replace('$', '')),
      max: parseInt(totalCost.html().replace('$', '')),
      disabled: true,
      range: "min"
    });
    progressWidth = parseInt($(this).find('.ui-slider-range').css('width').replace('px', ''));
    offset = progressWidth - charBasedOffset(progress.html().length);
    progress.css('left', offset > 0 ? (offset + 'px') : 0 );
  });
  $('.ui-slider-handle').hide();

  bindProjectToIframe();
  hideRoseIframe();
  bindPaymentSelection();
  bindModalClosing();
});

var bindProjectToIframe = function(){
  $('.project-donation').click(function(){
    $('#donation_choice_modal').data('project-id', $(this).data('project-id'));
  });
}

var charBasedOffset = function(charCount){
  return ({4: 7, 5: 14, 6: 21, 7: 28, 8: 35})[charCount]
}

var hideRoseIframe = function(){
  $('#donation_choice_modal .flash.success').hide();
  roseDonationIframe().hide();
}

var showRoseIframe = function(){
  $('#donation_choice_modal .flash.success').show();
  roseDonationIframe().show();
}

var bindPaymentSelection = function(){
  $('button[name=submit].btn-donation').click(function(){
    paymentGateway = $(this).data('payment-gateway');
    showPaymentGateway(paymentGateway);
  });
}

var showPaymentGateway = function(gateway){
  $('#donation_choice_modal').data('made_donation', true);
  if (gateway == 'rhit'){
    $('.modal-dialog').width('95%');
    $('.modal-content').height('90vh');
    $('iframe').height('78vh');
    $('.donation-instructions').hide();
    showRoseIframe();
  } else if (gateway == 'paypal') {
    $('#donation_choice_modal').modal('hide');
  }
}

var roseDonationIframe = function() {
  return $('iframe#rose-donation-frame')
}

var bindModalClosing = function(){
  $('#donation_choice_modal').on('hidden.bs.modal', function () {
    if ($(this).data('made_donation')){
      window.location = '/projects/' + $(this).data('project-id') + '/donations/new'
    }
    $('.donation-instructions').show();
    hideRoseIframe();
  })
}
