# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'twitter/bootstrap'
#= require 'bootstrap'

current_index = 0

thisHeight = ->
  $(this).height()

thisWidth = ->
  $(this).outerWidth()

goTo = (index)->
  $litoral = $("div.litoral > ul")
  if index < 0 or index > $litoral.children("li").length - 1
    return
  $li = $litoral.children('li:lt('+index+')')
  totalWidth = 0
  $.each $litoral.children('li:lt('+index+')').map(thisWidth), ->
    totalWidth += this or 0
    return
  $litoral.css({left: "-" + totalWidth + "px"})
  $('div.litoral').css({'background-position': "-" + totalWidth + "px bottom"});
  current_index = index

$(document).ready ->
  $litoral = $("div.litoral > ul")
  if $litoral.length > 0
    $litoral.height ->
      Math.max.apply Math, $(this).find("li:visible").map( thisHeight )
    totalWidth = 0
    $.each $litoral.find("li").map(thisWidth), ->
      totalWidth += this or 0
      return
    if totalWidth > $litoral.width()
      $litoral.width(totalWidth)
    else
      $litoral.width( $litoral.parent().outerWidth() )
    $litoral.css({left: '0px'})
    $('a.litoral-next').click ->
      goTo(current_index + 1)
    $('a.litoral-prev').click ->
      goTo(current_index - 1)
