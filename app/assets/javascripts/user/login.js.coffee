
#= require "jquery"
#= require 'jquery_ujs'
#= require 'jquery.remotipart'
#= require 'jquery.steps.min'
#= require 'jquery.mask.min'
#= require 'bootstrap-sprockets'
#= require 'bootstrap-datepicker.min'
#= require 'jquery_nested_form'
#= require 'pwstrength-bootstrap'
#= require 'jquery.validate.min'


$ ->

  $('[data-toggle="tooltip"]').tooltip()

  $(document).on 'click', '.btnNext', ->
    $('.nav-tabs > .active').next('li').find('a').trigger 'click'


  SHOW_CLASS = "show"
  HIDE_CLASS = "hide"
  ACTIVE_CLASS = "active"

  $(".nav-tabs").on "click", "li a", (e) ->
    e.preventDefault()
    $tab = $(this)
    href = $tab.attr("href")

    $(".active").removeClass(ACTIVE_CLASS)
    $tab.addClass(ACTIVE_CLASS)

    $(".show")
      .removeClass(SHOW_CLASS)
      .addClass(HIDE_CLASS)
      .hide()

    $(href)
      .removeClass(HIDE_CLASS)
      .addClass(SHOW_CLASS)
      .hide()
      .fadeIn(550)



  form = $('form#resume-form').show()

  $('#user_birthday').datepicker

  $("#user_phone").mask("9999-9999")
  $("#user_alt_phone").mask("9999-9999")
  $("#user_tax_id").mask("9999-999999-999-9")
  
  $("select#user_document_type").on  "change", ->
    if $(this).find(":selected").val() == "dui"
      alert "something"
      $("#user_document_number").mask("9999999-9")
    else
      $("#user_document_number").unmask()

  form.steps(
    headerTag: "h3"
    bodyTag: "section"
    transitionEffect: "fade"
    autoFocus: true
    labels: {
      previous: "Anterior"
      next: "Siguiente"
      finish: "Finalizar"
    }
    setStep: 5
    onStepChanging: (event, currentIndex, newIndex) ->
      if currentIndex > newIndex
        return true
      if currentIndex < newIndex
        form.find('.body:eq(' + newIndex + ') label.error').remove()
        form.find('.body:eq(' + newIndex + ') .error').removeClass 'error'
      form.validate().settings.ignore = ':disabled,:hidden'
      form.valid()
    onStepChanged: (event, currentIndex, priorIndex) ->
      if currentIndex == 2 and priorIndex == 3
        form.steps 'previous'
      return
    onFinishing: (event, currentIndex) ->
      form.validate().settings.ignore = ':disabled,:hidden'
      form.valid()
    onFinished: (event, currentIndex) ->
      form.submit()
      return
    ).validate(
      errorPlacement: (error, element) ->
        element.before error
        console.log error
        return
      rules: confirm: equalTo: '#user_password'
    )
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

  $('#user_password').pwstrength(options)
