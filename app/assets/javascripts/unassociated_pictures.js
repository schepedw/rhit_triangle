$(function(){
  setUnassociatedFileUpload();
});

var setUnassociatedFileUpload = function(){
  $.each($('.unassociated-fileupload'), function(_index, upload) {
    $(upload).fileupload({
      dropZone: $(upload),
      dataType: 'json',
      done: function (_e, data) {
        insertNewImages(data.result);
        insertSlideIndices(data.result);
        toggleCarouselControls();
        insertHiddenInputs(data.result);
      }
    });
  });
};

var insertSlideIndices = function(resultData){
  lastIndicator = $('#new-' + resultData.resourceType + '-carousel [data-slide-to]:last')
  maxIndex = lastIndicator.data('slide-to')
  $.each(resultData.newPictures, function(index, _picture){
    newIndicator = lastIndicator.clone();
    newIndicator.insertBefore(lastIndicator);
    newIndicator.data('slide-to', maxIndex + index)
  });
  lastIndicator.data('slide-to', maxIndex + resultData.newPictures.length);
  selector = '#new-' + resultData.resourceType + '-carousel';
  $(selector).carousel(resultData.newPictures.length - 1);
};

var insertNewImages = function(resultData){
  lastImage = $('#new-' + resultData.resourceType + '-carousel .carousel-inner .image-container:last')
  $.each(resultData.newPictures, function(_index, picture) {
    pic = $(picture);
    $(pic).insertBefore(lastImage);
    $(pic).find('.delete-picture').click(function(){
      rm_unassociated_picture($(this).prev('img'));
    });
  } )
};

var insertHiddenInputs = function(resultData){
  $.each(resultData.newPictures, function(_index, picture) {
    newInput = $('<input type="hidden" name="' + resultData.resourceType.toLowerCase() + '[pictures][]">');
    newInput.val($(picture).find('img').attr('src'))
    $('#new-' + resultData.resourceType + '-carousel').append(newInput);
  });
};

var toggleCarouselControls = function(resourceType){
  images = $('#new-' + resourceType + '-carousel .carousel-inner .image-container')
  if(images.length > 1)
    $('.carousel-control').addClass('hide');
  else
    $('.carousel-control').removeClass('hide');
}

var rm_unassociated_picture = function(image) {
  removeHiddenInputs(image);
  removeSlideIndices(image);
  resourceType = findResourceType(image);
  toggleCarouselControls(resourceType);
  removeImage(image);
  selector = '#new-' + resourceType + '-carousel';
  $(selector).carousel(0);
  $(selector + ' .image-container').first().addClass('active')
};

var removeImage = function(image){
  image.parents('.image-container').remove();
};

var removeHiddenInputs = function(image){
  $("input[value='" + image.attr('src') + "']").remove();
};

var removeSlideIndices = function(image){
  slideIndex = image.prevAll().length;
  image.parents('.carousel.slide').find(".carousel-indicators li")[slideIndex].remove()
};

var findResourceType = function(image){
  return image.closest(".carousel.slide").data('resource-type');
};
