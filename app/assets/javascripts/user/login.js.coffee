#= require "jquery"

$(document).ready ->

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
