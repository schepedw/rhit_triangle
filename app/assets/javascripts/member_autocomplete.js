$(function(){
  $('.taggit').autocomplete({
    serviceUrl: '/members',
    minChars: 2,
    delimiter: /(([\W]* |^)[^@][\S]+( *?|$)|@| )/, //TODO: this isn't perfect. '  @jim' will fail, for example
    triggerSelectOnValidInput: false,
    tabDisabled: true,
    onSelect: function() { $(this).focus(); },
    paramName: 'screen_name',
    orientation: 'top',
    dataType: 'json' })
})
