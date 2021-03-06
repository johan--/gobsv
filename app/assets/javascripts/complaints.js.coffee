# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'handlebars'
#= require 'jquery_nested_form'
#= require 'ckeditor/init'
#= require 'jquery.tagsinput'
#= require 'complaints/error-displayer'
#= require 'select2'
#= require 'select2_locale_es'
#= require 'jquery.remotipart'
#= require 'google-chart-loader'

$ ->

  $('.select2').select2
    theme: 'bootstrap'

  $('[data-toggle="tooltip"]').tooltip()

  # show spinner on AJAX start
  $(document).ajaxStart ->
    $('#spinner').show()
    return
  # hide spinner on AJAX stop
  $(document).ajaxStop ->
    $('#spinner').hide()
    return

  $(document).on 'ajax:start', 'form', (event, data, status, xhr) ->
    $('#spinner').show()
    return

  $(document).on 'ajax:stop', 'form', (event, data, status, xhr) ->
    $('#spinner').hide()
    return
