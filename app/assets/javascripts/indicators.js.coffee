# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'lightslider.min'
#= require 'modernizr'
#= require 'main'
#= require 'jquery.validate.min'
#= require 'jssocials'
#= require 'jssocials.shares'
#= require 'jquery.slick'

$(document).ready ->

  @mobileWeb = /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/i.test(navigator.userAgent)

  $("#lightSlider").lightSlider
    item:4,
    controls:false,
    responsive : [{ breakpoint:1024, settings: { item:4, slideMove:1, slideMargin:2, } }, { breakpoint:480, settings: { item:2, slideMove:1, slideMargin:2 } }],

  $("#lightSliderSA").lightSlider
    item:1,
    controls:false,
    responsive : [{ breakpoint:1024, settings: { item:1, slideMove:1, slideMargin:2, } }, { breakpoint:480, settings: { item:1, slideMove:1, slideMargin:2 } }],

