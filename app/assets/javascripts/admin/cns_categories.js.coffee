# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  readURL = (input) ->
    if input.files and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $("img#preview").attr "src", e.target.result
        return
      reader.readAsDataURL input.files[0]
    return


  $("a#image-url").on "click", (e) ->
    e.preventDefault()
    e.stopPropagation()
    $("#cns_category_icon").trigger "click"

  $("#cns_category_icon").on "change", ->
    readURL(this);
