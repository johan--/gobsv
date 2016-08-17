$ ->
  pickers = $('.daterange')

  $.each pickers, (i, picker) ->
    $(picker).daterangepicker(
      minViewMode: 'month',
      format: 'YYYY-MM-DD',
      minDate: $(picker).data('min'),
      maxDate: $(picker).data('max'),
      startDate: $(picker).data('start'),
      locale: {
        separator: ' - ',
        applyLabel: 'Aplicar',
        cancelLabel: 'Cancelar',
        fromLabel: 'Desde',
        toLabel: 'Hasta',
        customRangeLabel: 'Personalizado',
        weekLabel: 'W',
        firstDay: 1
      }
    )

  google.charts.load('current', { 'packages': ['table', 'corechart'] })

  $('#new_ofcia_payroll').on 'ajax:success', (e, response, status, xhr) ->
    data  = new google.visualization.DataTable()
    table = new google.visualization.Table(document.getElementById('matrix-data'))
    chart = new google.visualization.LineChart(document.getElementById('matrix-chart'))
    data.addColumn('date', 'Período')
    $.each response.header, (i, header) ->
      data.addColumn('number', header)

    matrix = $.map response.matrix, (row) ->
      [
        $.map row, (item, i) ->
          if i == 0
            return new Date(item)
          else
            return item
      ]

    data.addRows(matrix)

    chart.draw(data, {
      height: 450,
      hAxis: {
        format: 'MM/yyyy'
      }
    })

    table.draw(
      data,
      {
        width: '100%',
        height: '100%',
        hAxis: {
          format: 'MM/yyyy'
        }
      }
    )
