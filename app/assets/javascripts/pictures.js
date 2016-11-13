$(function(){
  setFileUpload();
});

var setFileUpload = function(){
  $.each($('.fileupload'), function(_index, upload) {
    $(upload).fileupload({
      dropZone: $(upload),
      dataType: 'json',
      drop: function (e, data) {
        $.each(data.files, function (index, file) {
        });
      },
      done: function (_e, data) {
        selector = '#image-carousel-' + data.result.resourceClass + '-' + data.result.resourceId
        $(selector).replaceWith(data.result.newHTML)
        uploadedImageIndex = $(selector + ' .image-container img').toArray().indexOf($("img[src='" + data.result.newPicture + "']")[0]);
        $(selector).carousel(uploadedImageIndex);
        setFileUpload();
      }
    });
  });
};
