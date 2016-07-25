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

  hideRoseIframe();
  bindPaymentSelection();
  bindFrequencySelection();
  bindModalClosing();
});

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
  $('input[name=submit]').click(function(){
    paymentGateway = $(this).data('payment-gateway');
    if (!donationFormValid())
      return;

    saveDonationDetails(paymentGateway);
    showPaymentGateway(paymentGateway);
  });
}

var saveDonationDetails = function(paymentGateway){
  $.ajax(
    '/donations',
    {
      method: 'post',
      data:
        {
          authenticity_token: $('input[name=authenticity_token]').val(),
          donation: {
            amount: donationAmount(),
            frequency: donationFrequency(),
            payment_gateway: paymentGateway
          }},
          success: function() { console.log('success!') },
          error: function() { console.log('error') },
    }
  )
}

var donationAmount = function(){
  return parseInt($('#donation_amount').val()) || 0;
}

var donationFrequency = function(){
  return $("[name='donation[frequency]']:checked").val();
}

var showPaymentGateway = function(gateway){
  $('.modal-dialog').width('95%');
  $('.modal-content').height('90vh');
  $('iframe').height('78vh');
  $('.donation-instructions').hide();
  if (gateway == 'rhit'){
    showRoseIframe();
  } else if (gateway == 'paypal') {

  }
}

var roseDonationIframe = function() {
  return $('iframe#rose-donation-frame')
}

var donationFormValid = function(){
  if (donationAmount() == 0)
    $('#donation_amount').siblings('label').addClass('invalid')
  else
    $('#donation_amount').siblings('label').removeClass('invalid')

  if (donationFrequency() == undefined)
    $("[name='donation[frequency]']").siblings('label[required=required]').addClass('invalid')
  else
    $("[name='donation[frequency]']").siblings('label[required=required]').removeClass('invalid')

  return $('.donation-instructions .invalid').length == 0
}

var bindModalClosing = function(){
  $('#donation_choice_modal').on('hidden.bs.modal', function () {
    $('.donation-instructions').show();
    hideRoseIframe();
    // if we've made a donation, redirect to /donations/new
  })
}

var bindFrequencySelection = function(){
  $("[name='donation[frequency]']").click(function(){
    console.log('hello');
  });
}

var updatePaypalForm = function(){

}
