//
//    Main script of DevOOPS Bootstrap Theme
//
"use strict";

//
//  Function maked all .box selector is draggable, to disable for concrete element add class .no-drop
//
function WinMove() {
  $("div.box").not('.no-drop')
          .draggable({
            revert: true,
            zIndex: 2000,
            cursor: "crosshair",
            handle: '.box-name',
            opacity: 0.8
          })
          .droppable({
            tolerance: 'pointer',
            drop: function (event, ui) {
              var draggable = ui.draggable;
              var droppable = $(this);
              var dragPos = draggable.position();
              var dropPos = droppable.position();
              draggable.swap(droppable);
              setTimeout(function () {
                var dropmap = droppable.find('[id^=map-]');
                var dragmap = draggable.find('[id^=map-]');
                if (dragmap.length > 0 || dropmap.length > 0) {
                  dragmap.resize();
                  dropmap.resize();
                }
                else {
                  draggable.resize();
                  droppable.resize();
                }
              }, 50);
              setTimeout(function () {
                draggable.find('[id^=map-]').resize();
                droppable.find('[id^=map-]').resize();
              }, 250);
            }
          });
}
//
// Swap 2 elements on page. Used by WinMove function
//
jQuery.fn.swap = function (b) {
  b = jQuery(b)[0];
  var a = this[0];
  var t = a.parentNode.insertBefore(document.createTextNode(''), a);
  b.parentNode.insertBefore(a, b);
  t.parentNode.insertBefore(b, t);
  t.parentNode.removeChild(t);
  return this;
};
/*-------------------------------------------
 Function for File upload page (form_file_uploader.html)
 ---------------------------------------------*/
function FileUpload() {
  $('#bootstrapped-fine-uploader').fineUploader({
    template: 'qq-template-bootstrap',
    classes: {
      success: 'alert alert-success',
      fail: 'alert alert-error'
    },
    thumbnails: {
      placeholders: {
        waitingPath: "../assets/fineuploader/waiting-generic.png",
        notAvailablePath: "../assets/fineuploader/not_available-generic.png"
      }
    },
    request: {
      endpoint: appContext + '/fileUpload'
    },
    validation: {
      allowedExtensions: ['jpeg', 'jpg', 'gif', 'png']
    }
  });
}

//
//  Function set min-height of window (required for this theme)
//
function SetMinBlockHeight(elem) {
  elem.css('min-height', window.innerHeight - 49)
}
//
//  Helper for correct size of Messages page
//
function MessagesMenuWidth() {
  var W = window.innerWidth;
  var W_menu = $('#sidebar-left').outerWidth();
  var w_messages = (W - W_menu) * 16.666666666666664 / 100;
  $('#messages-menu').width(w_messages);
}
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//
//      MAIN DOCUMENT READY SCRIPT OF DEVOOPS THEME
//
//      In this script main logic of theme
//
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
$(document).ready(function () {
  // required for sidebar toggle
  $('.show-sidebar').on('click', function (e) {
    e.preventDefault();
    $('div#main').toggleClass('sidebar-show');
    setTimeout(MessagesMenuWidth, 250);
  });
  // required for sidebar dropdown
  $('.main-menu').on('click', 'a', function (e) {
    var parents = $(this).parents('li');
    var li = $(this).closest('li.dropdown');
    var another_items = $('.main-menu li').not(parents);
    another_items.find('a').removeClass('active');
    another_items.find('a').removeClass('active-parent');
    if ($(this).hasClass('dropdown-toggle') || $(this).closest('li').find('ul').length === 0) {
      $(this).addClass('active-parent');
      var current = $(this).next();
      if (current.is(':visible')) {
        li.find("ul.dropdown-menu").slideUp('fast');
        li.find("ul.dropdown-menu a").removeClass('active')
      }
      else {
        another_items.find("ul.dropdown-menu").slideUp('fast');
        current.slideDown('fast');
      }
    }
    else {
      if (li.find('a.dropdown-toggle').hasClass('active-parent')) {
        var pre = $(this).closest('ul.dropdown-menu');
        pre.find("li.dropdown").not($(this).closest('li')).find('ul.dropdown-menu').slideUp('fast');
      }
    }
    if ($(this).hasClass('active') === false) {
      $(this).parents("ul.dropdown-menu").find('a').removeClass('active');
      $(this).addClass('active')
    }

    if ($(this).attr('href') === '#') {
      e.preventDefault();
    }
  });

});
