# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'jquery.sharrre'
#= require 'jquery.jpages'
#= require 'jquery.scrollto'

$ ->
  $("#shareme").sharrre {
    share: {
      googlePlus: true,
      facebook: true,
      twitter: true,
      digg: true,
      delicious: true
    },
    enableTracking: true,
    buttons: {
      googlePlus: { size: "tall", annotation:"bubble" },
      facebook: { layout: "box_count" },
      twitter: { count: "vertical" },
      digg: { type: "DiggMedium" },
      delicious: { size: "tall" }
    },
    hover: (api, options) ->
      $(api.element).find(".buttons").show()
    ,
    hide: (api, options) ->
      $(api.element).find(".buttons").hide()
  }

  $(".jpages-holder").jPages {
    containerID: "comments",
    previous: "",
    next: "",
    perPage: 5,
    fallback: 500,
    minHeight: false,
    callback: (pages, items) ->
      $(window).scrollTo($("#article-info").position().top - 30)
  }

  $("#new_ta_comment").on "ajax:success", (e, data, status, xhr) ->
    $("#new-comment .well").replaceWith("<div class='alert alert-success text-center'>¡Tu comentario ha sido enviado correctamente!</div>")

  $("#new_ta_comment").on "ajax:error", (e, xhr, status, error) ->
    $(this).find(".help-block").remove()
    $(this).find(".has-error input").unwrap()
    for key, val of xhr.responseJSON
      input = $(this).find("[name='ta_comment[#{key}]']")
      input.wrap("<div class='has-error'></div>")
      input.after("<div class='help-block'>#{val[0]}</div>")
