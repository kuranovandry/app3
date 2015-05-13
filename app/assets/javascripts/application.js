// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery-ui
//= require_tree .

$(function() {
  $('.datepicker').datepicker();

  function popupCenter(url, width, height, name) {
    var left = (screen.width / 2) - (width / 2);
    var top = (screen.height / 2) - (height / 2);
    popupValue = "on";
    return window.open(url, name, "menubar=no, toolbar=no, status=no, width=" + width + ", height=" + height + ", toolbar=no, left=" + left + ", top=" + top);
  }

  $(".popup").click(function(e) {
    popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
    e.stopPropagation(); return false;
  });

  if(window.opener && window.opener.popupValue === 'on') {
    delete window.opener.popupValue;
    window.opener.location.reload(true);
    window.close()
  }
});
