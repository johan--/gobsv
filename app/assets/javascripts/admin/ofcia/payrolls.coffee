$ ->
  format_date = (date, format) ->
    date = new Date(date)
    date.setMinutes(date.getTimezoneOffset())
    if format == 'yyyy'
      date.getFullYear()
    else
      "#{date.getMonth() + 1}/#{date.getFullYear()}"


  format  = null
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

  $('#new_ofcia_payroll').on 'ajax:send', (xhr) ->
    $('.overlay').show()
    if $('#ofcia_payroll_field').val() == 'total_avg' || $('#ofcia_payroll_field').val() == 'amount_total_avg' || $('#ofcia_payroll_field').val() == 'percapita_year'
      format = 'yyyy'
    else
      format = 'MM/yyyy'

  $('#new_ofcia_payroll').on 'ajax:success', (e, response, status, xhr) ->

    ## DATA FOR GRAPHIC

    data  = new google.visualization.DataTable()
    table = new google.visualization.Table(document.getElementById('matrix-data'))
    chart = new google.visualization.LineChart(document.getElementById('matrix-chart'))
    forma = new google.visualization.DateFormat({ pattern: format })

    data.addColumn('date', 'Período')
    $.each response.header, (i, header) ->
      data.addColumn('number', header)

    matrix = $.map response.matrix, (row) ->
      [
        $.map row, (item, i) ->
          if i == 0
            d = new Date(item)
            d.setMinutes(d.getTimezoneOffset())
            return d
          else
            return parseFloat(item)
      ]

    data.addRows(matrix)

    forma.format(data, 0)

    chart.draw(data, {
      height: 450,
      hAxis: {
        format: format
      }
    })


    ## DATA FOR TABLE
    data  = new google.visualization.DataTable()

    temporal_header = []
    $.each response.matrix, (i, m) ->
      temporal_header.push(m[0])

    temporal_matrix = []
    temporal_row = []
    $.each response.header, (i, h) ->
      temporal_row.push(h)
      $.each response.matrix, (j, m) ->
        temporal_row.push(m[i+1])
      temporal_matrix.push(temporal_row)
      temporal_row = []

    data.addColumn('string', 'Clasificación')
    $.each temporal_header, (i, header) ->
      data.addColumn('number', format_date(header, format))

    matrix = $.map temporal_matrix, (row) ->
      [
        $.map row, (item, i) ->
          if i == 0
            return item
          else
            return parseFloat(item)
      ]

    data.addRows(matrix)
    forma.format(data, 0)

    table.draw(
      data,
      {
        width: '100%',
        height: '100%',
        hAxis: {
          format: format
        }
      }
    )

    $('.overlay').hide()
