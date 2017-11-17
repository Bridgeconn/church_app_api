//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require jquery.easing
//= require sb-admin
//= require moment.min
//= require jquery.datetimepicker

$(document).ready(function () {
  $(".alert").fadeOut(3000);
});

$(function () {
    $('#datetimepicker1').appendDtpicker();
    $('#datetimepicker2').appendDtpicker();
});
