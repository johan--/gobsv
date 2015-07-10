# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'handlebars'
#= require 'jquery_nested_form'
#= require 'dataTables/jquery.dataTables'
#= require 'dataTables/bootstrap/3/jquery.dataTables.bootstrap'
#= require 'admin/tables'
#= require 'admin/forms'
#= require 'ckeditor/init'
#= require 'jquery.tagsinput'

$ ->
  ##
  # Tags
  $(".tags").tagsInput
    width: "100%",
    defaultText: "",
    delimiter: [","]

window.NestedFormEvents.prototype.insertFields = (content, assoc, link) ->
  if $(link).closest(".form-gallery").length > 0
    last = $(link).closest(".form-gallery").find(".fields:last")
    content = $(content)
    input = content.find("input[type=file]")
    input.on "change", ->
      content.insertBefore(last)
      if this.files and this.files[0]
        reader = new FileReader()
        reader.onload = (e) ->
          content.find("img").attr "src", e.target.result
        reader.readAsDataURL this.files[0]
    input.trigger("click")
