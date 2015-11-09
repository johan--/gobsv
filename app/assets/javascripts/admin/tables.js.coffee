$(document).ready ->

  $tables = $(".data-table")
  $tables.each ->

    columns = []

    if $("#buttonstpl").length > 0
      buttons = $("#buttonstpl").html()
      template = Handlebars.compile(buttons)
      $(this).find("thead tr:first").append($("<th />"))

    $(this).find("[data-attribute]").each ->
      columns.push { data: $(this).attr("data-attribute") }

    $(this).find("[data-invisible]").each ->
      columns.push { data: $(this).attr("data-invisible"), visible: false }


    $(this).dataTable {
      lengthChange: false,
      deferRender: true,
      ajax: { url: "#{document.URL}.json", dataSrc: "" },
      columnDefs: [{
        data: null,
        defaultContent: "",
        targets: "_all"
      }],
      columns: columns,
      createdRow: (row, data, dataIndex) ->
        if template?
          $(row).append(
            $("<td />").append(
              $(template({ id: data.id }))
            )
          )
      ,
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
    }
