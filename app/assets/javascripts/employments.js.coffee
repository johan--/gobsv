# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'jssocials'
#= require 'jssocials.shares'
#= require 'jquery.steps.min'
#= require 'pwstrength-bootstrap'
#= require 'select2'
#= require 'select2_locale_es'

$ ->
  $('[data-toggle="tooltip"]').tooltip()

  $(document).on 'click', '.btnNext', ->
    $('.nav-tabs > .active').next('li').find('a').trigger 'click'


  $('form#resume-form').steps
    headerTag: "h3"
    bodyTag: "section"
    transitionEffect: "fade"
    autoFocus: true
    labels: {
      previous: "Anterior"
      next: "Siguiente"
      finish: "Finalizar"
    }

  options = {}
  options.ui =
    container: "#pwd-container"
    showErrors: true
    showProgressBar: true
    showVerdictsInsideProgressBar: true
    viewports: {
      progress: ".pwstrength_viewport_progress"
      errors: ".pwstrength_viewport_errors"
    }

  $('#password').pwstrength(options)

  $('.select2').select2
    theme: 'bootstrap'

  ##
  # Nested form callback
  $(document).on "nested:fieldAdded", (event) ->
    $('.select2').select2
      theme: 'bootstrap'
