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
    a = $("<a />").
          addClass("input-file").
          addClass("btn").
          addClass("btn-default").
          text("Seleccione una imagen")

    $(self).before(
      a.on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()
        $(self).trigger "click"
    )

    $(self).on "change", ->
      readURL(self, img)
      img.css("height", a.outerHeight())

    $(self).hide()
