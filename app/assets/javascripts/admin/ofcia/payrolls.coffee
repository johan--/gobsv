$ ->
  form = null
  $(".add-payroll-view").on "click", (e) ->
    e.preventDefault()
    source   = $("#report-form-tpl").html()
    template = Handlebars.compile(source)
    context  = {}
    html     = $(template(context))
    $("#payroll-views").append(html)

    html.find("form").on "ajax:success", (e, data, status, xhr) ->
      html.find("table").DataTable {
        data: data,
        columns: [{ title: "" }, { title: "" }],
        paging: false,
        ordering: false,
        searching: false,
        info: false
      }
