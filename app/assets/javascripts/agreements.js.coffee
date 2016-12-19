# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'jquery.validate.min'
#= require 'jssocials'
#= require 'jssocials.shares'
#= require 'jquery.slick'
#= require 'complaints/error-displayer'
#= require 'modernizr'
#= require 'turn.min'
#= require 'hash'
#= require 'scissor.min'
#= require 'zoom.min'

$ ->

  @mobileWeb = /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/i.test(navigator.userAgent)

  $(document).on 'change', '#agreements_user_peace_signature_country', (e) ->
    url = 'dashboard/' + $(this).val() + '/get_states'
    selectbox2 = $('#agreements_user_peace_signature_state')
    selectbox2.empty()
    $('#agreements_user_peace_signature_state').append "<option value=0>-- Estado --</option>"
    $.get url, ((data) ->

      if data.length > 0

        selectbox2.show()

        $.each data, (key, value) ->

          opt = $('<option/>')
          # value is an array: [:id, :name]
          opt.attr 'value', value[0]
          # set text
          opt.text value[1]
          # append to select
          opt.appendTo selectbox2
        return
      else
        selectbox2.hide()
      return

    ), 'json'
    return


  $('a#event-handler').on 'click', (event) ->
    $anchor = $(this)
    target = $($anchor.attr('href'))
    if target.length
      event.preventDefault()
      $('html, body').stop(true,true).animate { scrollTop: target.offset().top }, 1000
    return

  $('.sharer').jsSocials
    showLabel: true,
    text: "Yo firme los acuerdos de paz. Reafirma el compromiso por la paz vos tambien. #SoyPaz #El Salvador",
    shares: ["twitter", "facebook", "googleplus", "pinterest"]

  $("#peace-form").validate
    rules:
      'agreements_user_peace_signature[name]':
        required: true
      'agreements_user_peace_signature[country]':
        required: true
      'agreements_user_peace_signature[email]':
        required: true
        email: true
    messages:
      'agreements_user_peace_signature[email]':
        email: "Ingrese un correo electrónico válido"

  do ->
  'use strict'

  module =
    ratio: 1.38
    init: (id) ->
      me = this
      if document.addEventListener
        @el = document.getElementById(id)
        @resize()
        @plugins()
        # on window resize, update the plugin size
        window.addEventListener 'resize', (e) ->
          size = me.resize()
          $(me.el).turn 'size', size.width, size.height
          return
      return

    resize: ->
      @el.style.width = ''
      @el.style.height = ''
      width = @el.clientWidth
      height = Math.round(width / @ratio)
      padded = Math.round(document.body.clientHeight * 0.9)
      # if the height is too big for the window, constrain it
      if height > padded
        height = padded
        width = Math.round(height * @ratio)
      # set the width and height matching the aspect ratio
      @el.style.width = width + 'px'
      @el.style.height = height + 'px'
      {
        width: width
        height: height
      }
    plugins: ->
      # run the plugin
      $(@el).turn
        gradients: true
        acceleration: true
        autoCenter: true
        zoom: 0.5
      # hide the body overflow
      document.body.className = 'hide-overflow'
      return
  module.init 'book'
  module.init 'book2'
  return
