# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'jssocials'
#= require 'jssocials.shares'

$ ->
  $('[data-toggle="tooltip"]').tooltip()

  $(document).on 'click', '.btnNext', ->
    $('.nav-tabs > .active').next('li').find('a').trigger 'click'
