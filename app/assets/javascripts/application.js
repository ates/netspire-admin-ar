// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui

$(document).ready(function() {
  // Init template elements
  $.templates.init();

  // Dropdown menu
  $("body").bind("click", function (e) {
    $('a.menu').parent("li").removeClass("open");
  });

  $("a.menu").click(function (e) {
    var $li = $(this).parent("li").toggleClass('open');
    return false;
  });

  // Display ajax progress
  $('#spinner').ajaxSpinner();

  // fadeout flash messages
  $("div#[id^='flash_']").fadeOut(3000);
});

/*
 * Element acts as Ajax progress.
 */
(function($) {
    $.fn.extend({
        ajaxSpinner: function() {
            return this.each(function() {
                var element = $(this);
                element.ajaxStart(function() {
                    $(this).css('position', 'fixed').show();
                });
                element.ajaxStop(function() {
                    $(this).hide();
                });
            });
        }
    });
})(jQuery);
