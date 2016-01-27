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

$(document).ready ->
  $("#lightSlider").lightSlider
    item:4,
    controls:false,
    responsive : [{ breakpoint:800, settings: { item:3, slideMove:1, slideMargin:6, } }, { breakpoint:480, settings: { item:2, slideMove:1 } }],
