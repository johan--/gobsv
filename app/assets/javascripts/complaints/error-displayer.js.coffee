class @ErrorDisplayer

  constructor: (form, errors) ->

    @form = form
    @errors = errors
    @append_errors()
    window.location.hash = "#"

  append_error: (field_name, messages) ->

    if @form.find("[name='#{field_name}']").length > 0
      field = @form.find("[name='#{field_name}']")
    else
      field = @form.find("[name*='[#{field_name}]']")
    error_container = @get_error_container(field)
    error_message_container = @get_error_message_container(field)

    error_message_container.text(messages[0])

    field.parent().append(error_container)
    error_container
      .append(field)
      .append(error_message_container)

  append_errors: ->
    $.each @errors, (field_name, messages) =>
      @append_error(field_name, messages)

  get_error_container: (field) ->
    if @field_has_already_error(field)
      field.parent().find("div[class=field-with-errors]")
    else
      $("<div />").addClass("field-with-errors")

  get_error_message_container: (field) ->
    if @field_has_already_error(field)
      field.parent().find("label[class=message]")
    else
      $("<label />").addClass("message")

  field_has_already_error: (field) ->
    field.parent().find("label[class=message]").length > 0
