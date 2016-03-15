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

$ ->

  $('.select2').select2
    theme: 'bootstrap'

  $('[data-toggle="tooltip"]').tooltip()
