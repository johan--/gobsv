$ ->
  form = null
  $(".add-payroll-view").on "click", (e) ->
    e.preventDefault()
    source   = $("#report-form-tpl").html()
    template = Handlebars.compile(source)
    context  = {}
    html     = $(template(context))
    $("#payroll-views").append(html)

    datatable = html.find("table").DataTable {
      columns: [{ data: "name", title: "" }, { data: "count", title: "" }],
      paging: false,
      ordering: false,
      searching: false,
      info: false,
      loadingRecords: "Cargando ...",
      emptyTable: "No se encontraron resultados",
      createdRow: (row, data, dataIndex) ->
        $(row).addClass("level-#{data.level}")
    }

    html.find("form").data("datatable", datatable)
    html.find("form").on "ajax:success", (e, data, status, xhr) ->
      d = $(this).data("datatable")
      d.clear()
      d.rows.add(data)
      d.draw()
