# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("button.close").click ->
    $(this).next().click()
  $('.commentField').keyup (e) ->
    if e.which is 13 and !e.shiftKey
      $('form#commentform').submit()
