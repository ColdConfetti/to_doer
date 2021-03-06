// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require_tree .
//= require bootstrap-sprockets
//= require redactor-rails
//= require bootstrap-datepicker

$(document).ready(function() {
  $('.checkable').click(function() {
    $(this).parents('form:first').submit();
    $(this).fadeOut();
    $(this).parent().parent().parent().animate({
      opacity: 0.5,
      height: "0px",
      padding: "0",
      margin: "0"
      }, 1000, function() {
        $(this).parent().detach();
        // $(this).parent().find(
        // $('.delete').faedOut();
    });
  }); // end checkable click

  $('.datepicker').datepicker(); // datepicker

  $('#manage').click(function() {
    $('.delete').fadeToggle();
  }); //manage click

  $('.delete').click(function() {
    $(this).parent().parent().detach();
  }); //delete click

}); //end ready