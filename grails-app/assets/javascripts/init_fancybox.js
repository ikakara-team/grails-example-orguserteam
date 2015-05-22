"use strict";

function InitFancybox(url) {
  $('.fancybox').fancybox({
    openEffect: 'none',
    closeEffect: 'none',
    afterShow: function () {
      $('<div class="video_delete"></div>').appendTo(this.inner).click(function () {
        var video = GetVideo();
        window.parent.location.href = url + '/videos-delete/' + video;
      });

      $('<div class="video_edit"></div>').appendTo(this.inner).click(function () {
        var video = GetVideo();
        window.parent.location.href = url + '/videos/' + video;
      });
    },
    afterClose: function () {
      //$(document).fullScreen(false);
    }
  });
}

function GetVideo() {
  var src = $('iframe').attr('src');
  var myRegexp = /\/\/(.*)\/folders\/(.*)\/videos\/(.*)/g;
  var match = myRegexp.exec(src);
  return match[3];
}
