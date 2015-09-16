# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#movie_tag_list_tokens').tokenInput '/movies/tags.json',
    theme: 'mac'
    minChars: 2
    allowCustomEntry: true
    preventDuplicates: true
    prePopulate: $('#movie_tag_list_tokens').data('load')
