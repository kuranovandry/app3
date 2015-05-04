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
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .

 $(function () {
    $('.datetimepicker_start').datetimepicker();
    $('.datetimepicker_end').datetimepicker();
    $(".datetimepicker_start").on("dp.change", function (e) {
        $('.datetimepicker_end').data("DateTimePicker").minDate(e.date);
    });
    $(".datetimepicker_end").on("dp.change", function (e) {
        $('.datetimepicker_start').data("DateTimePicker").maxDate(e.date);
    });
});
