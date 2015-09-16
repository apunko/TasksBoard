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
//= require twitter/bootstrap
//= require pagedown_bootstrap
//= require pagedown_init
//= require rails-jquery-tokeninput
//= require turbolinks
//= require_tree .

$(function() {
  init();
  $(document).ready(function () {
  //  alert("ready")
  });

  var ENTER = 13;
  $(".token-input-input-token-facebook").keyup(function (event) {
    if (event.keyCode == ENTER) {
      $("#search").blur();
    }
  });
  $(document).on('page:load', ready)
});



function ready(){
 // alert("load");
}

function init() {
  $(".EditAnswerLink").click(function () {
  //  alert("click");
  });
  //alert("init");
}