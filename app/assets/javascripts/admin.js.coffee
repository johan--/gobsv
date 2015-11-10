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
#= require 'admin/inv/product_movements'
#= require 'ckeditor/init'
#= require 'jquery.tagsinput'
#= require 'select2'
#= require 'select2_locale_es'

$ ->
  $('.select2').select2
    theme: 'bootstrap'

  ##
  # Tags
  $(".tags").tagsInput
    width: "100%",
    defaultText: "",
    delimiter: [","]

  $(".simple-data-table").DataTable(
    lengthChange: false,
    language: {
      loadingRecords: "Cargando ...",
      emptyTable: "No se encontraron resultados",
      zeroRecords: "No se encontraron resultados",
      info: "Mostrando desde _START_ hasta _END_ de _TOTAL_ registros",
      infoEmpty: "Mostrando desde 0 hasta 0 de 0 registros",
      infoFiltered: "(filtrado de _MAX_ registros en total)",
      search: "Filtro rápido: ",
      paginate: {
        previous: "Anterior",
        next: "Siguiente"
      }
    }
  )

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
  else
    target = $(link).data('target')
    if target
      $(content).appendTo($(target))
    else
      $(content).insertBefore(link)


$(document).on "nested:fieldAdded", (event) ->
  field = event.field
  field.find(".select2").select2 theme: "bootstrap"
