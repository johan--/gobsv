# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'jquery.jpages'
#= require 'jquery.scrollto'
#= require 'fullsizable'
#= require 'jssocials'
#= require 'jssocials.shares'

$ ->
  $(".fullsizable").fullsizable()

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

  $(".sharer").jsSocials(
    showCount: true,
    showLabel: true,
    openInPopup: false,
    shares: ["twitter", "facebook", "googleplus", "pinterest"]
  )

  $("#new_ta_comment").on "ajax:success", (e, data, status, xhr) ->
    $("#new-comment .well").replaceWith("<div class='alert alert-success text-center'>¡Tu comentario ha sido enviado correctamente!</div>")

  $("#new_ta_comment").on "ajax:error", (e, xhr, status, error) ->
    $(this).find(".help-block").remove()
    $(this).find(".has-error input").unwrap()
    for key, val of xhr.responseJSON
      input = $(this).find("[name='ta_comment[#{key}]']")
      input.wrap("<div class='has-error'></div>")
      input.after("<div class='help-block'>#{val[0]}</div>")


  $(".toggable-container .tabs a").on "click", (e) ->
    $(this).closest(".toggable-container").find(".toggable").fadeOut()
    $($(this).attr("href")).fadeIn()
    $(this).closest(".tabs").
      removeClass("pct").
      removeClass("aud").
      removeClass("vdo").
      addClass($($(this).attr("href")).attr("id"))
    $(this).trigger("blur")

    e.preventDefault()
  $(".toggable-container .tabs a:first").trigger("click")

  $("#article .content img").each ->
    if $(this).attr("alt") && $(this).attr("alt") != ""
      figure = $("<figure />")
      figure.addClass("img-responsive")
      $(this).addClass("img-responsive")
      figure.width($(this).width())
      figcaption = $("<figcaption />")
      figcaption.text($(this).attr("alt"))
      #figcaption.text($(this).attr("alt"))
      $(this).wrap(figure)
      figcaption.insertAfter($(this))
