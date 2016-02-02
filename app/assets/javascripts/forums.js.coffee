# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'lightslider.min'
#= require 'modernizr'
#= require 'main'
#= require 'forums/twitterFetcher'
#= require 'forums/SalarioMinimo'
#= require 'forums/jquery-queryParser.min'

$(document).ready ->
  $("#lightSlider").lightSlider
    item:4,
    controls:false,
    responsive : [{ breakpoint:800, settings: { item:3, slideMove:1, slideMargin:6, } }, { breakpoint:480, settings: { item:2, slideMove:1 } }],


  $('a.play-video').on 'click', (e) ->
    # Store the query string variables and values
    # Uses "jQuery Query Parser" plugin, to allow for various URL formats (could have extra parameters)
    queryString = $(this).attr('href').slice($(this).attr('href').indexOf('?') + 1)
    queryVars = $.parseQuery(queryString)
    # if GET variable "v" exists. This is the Youtube Video ID
    if 'v' of queryVars
      # Prevent opening of external page
      e.preventDefault()
      # Variables for iFrame code. Width and height from data attributes, else use default.
      vidWidth = 760
      # default
      vidHeight = 428
      # default
      if $(this).attr('data-width')
        vidWidth = parseInt($(this).attr('data-width'))
      if $(this).attr('data-height')
        vidHeight = parseInt($(this).attr('data-height'))
      iFrameCode = '<iframe width="' + vidWidth + '" height="' + vidHeight + '" scrolling="no" allowtransparency="true" allowfullscreen="true" src="http://www.youtube.com/embed/' + queryVars['v'] + '?rel=0&wmode=transparent&showinfo=0" frameborder="0"></iframe>'
      # Replace Modal HTML with iFrame Embed
      $('#mediaModal .modal-body').html iFrameCode
      # Replace Modal title with link title
      $('#mediaModal .modal-title').html $(this).attr('title')
      # Set new width of modal window, based on dynamic video content
      $('#mediaModal').on 'show.bs.modal', ->
        # Add video width to left and right padding, to get new width of modal window
        modalBody = $(this).find('.modal-body')
        modalDialog = $(this).find('.modal-dialog')
        newModalWidth = vidWidth + parseInt(modalBody.css('padding-left')) + parseInt(modalBody.css('padding-right'))
        newModalWidth += parseInt(modalDialog.css('padding-left')) + parseInt(modalDialog.css('padding-right'))
        newModalWidth += 'px'
        # Set width of modal (Bootstrap 3.0)
        $(this).find('.modal-dialog').css 'width', newModalWidth
        return
      # Open Modal
      $('#mediaModal').modal()
    return
  # Clear modal contents on close.
  # There was mention of videos that kept playing in the background.
  $('#mediaModal').on 'hidden.bs.modal', ->
    $('#mediaModal .modal-body').html ''
    return