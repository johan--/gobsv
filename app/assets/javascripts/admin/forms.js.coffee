$(document).ready ->

  readURL = (input, previewer) ->
    if input.files and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        previewer.attr "src", e.target.result
        return
      reader.readAsDataURL input.files[0]
    return

  $("[data-preview]").each ->

    self = this
    img = $(self).next("img")
    img.addClass("img-preview")

    $(self).on "change", ->
      readURL(self, img)

    $(self).before($("<br />"))
    $(self).before(
      $("<a />").
        addClass("input-file").
        addClass("btn").
        addClass("btn-default").
        text("Seleccione una imagen").
        on "click", (e) ->
          e.preventDefault()
          e.stopPropagation()
          $(self).trigger "click"
    )

    $(self).hide()
