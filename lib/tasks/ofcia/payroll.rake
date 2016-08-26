namespace :ofcia do
  namespace :payrolls do
    desc 'Carga la tabla ofcia_payrolls'
    task load: [:environment] do

      client = Savon.client(
        wsdl: 'https://app-qas.isss.gob.sv:8890/CapresEndPoint/TransactionExecutorPort?WSDL',
        ssl_verify_mode: :none
      )

      procesamiento = ::Ofcia::Payroll.order(id_procesamiento: :desc).first.try(:id_procesamiento)
      response      = client.call(:cargar_planilla_capres, message: { arg0: procesamiento })
      json_string   = response.body[:cargar_planilla_capres_response][:return].to_s
      items         = JSON.parse(json_string)

      items.each do |item|
        payroll = ::Ofcia::Payroll.where(id_procesamiento: item['idProcesamiento']).first_or_initialize
        payroll.periodo = item['periodo']
        payroll.id_causa_complemento = item['idCausaComplemento']
        payroll.tasa_cotiz_lab_ivm = item['tasaCotizLabIVM']
        payroll.impresa = item['impresa']
        payroll.tipo_mora = item['tipoMora']
        payroll.maximo_cotizable_fsv = item['maximoCotizableFSV']
        payroll.correlativo_centro_trabajo = item['correlativoCentroTrabajo']
        payroll.cambio_nota_detalle = item['cambioNotaDetalle']
        payroll.id_usuario = item['idUsuario']
        payroll.correlativo_original_migracion = item['correlativoOriginalMigracion']
        payroll.id_codigo_observacion = item['idCodigoObservacion']
        payroll.id_sucursal = item['idSucursal']
        payroll.aporte_pat_ivm = item['aportePatIVM']
        payroll.horas = item['horas']
        payroll.tasa_cotiz_pat_ivm = item['tasaCotizPatIVM']
        payroll.tasa_cotiz_pat_fsv = item['tasaCotizPatFSV']
        payroll.maximo_cotizable = item['maximoCotizable']
        payroll.aporte_patronal = item['aportePatronal']
        payroll.monto_vacacion = item['montoVacacion']
        payroll.monto_salario = item['montoSalario']
        payroll.id_tipo_pago_planilla = item['idTipoPagoPlanilla']
        payroll.aporte_total_ivm = item['aporteTotalIVM']
        payroll.aporte_total = item['aporteTotal']
        payroll.id_estado_planilla = item['idEstadoPlanilla']
        payroll.tasa_cotiz_laboral = item['tasaCotizLaboral']
        payroll.monto_pago_adicional = item['montoPagoAdicional']
        payroll.id_tipo_planilla = item['idTipoPlanilla']
        payroll.aporte_total_fsv = item['aporteTotalFSV']
        payroll.aporte_lab_fsv = item['aporteLabFSV']
        payroll.cambio_nota = item['cambioNota']
        payroll.aporte_laboral = item['aporteLaboral']
        payroll.tasa_cotiz_patronal = item['tasaCotizPatronal']
        payroll.no_afiliacion_trabajador = item['noAfiliacionTrabajador']
        payroll.mecanizada = item['mecanizada']
        payroll.tasa_cotiz_lab_fsv = item['tasaCotizLabFSV']
        payroll.dias = item['dias']
        payroll.no_patronal = item['noPatronal']
        payroll.maximo_cotizable_ivm = item['maximoCotizableIVM']
        payroll.fecha_presentacion_planilla = (Date.new(item['fechaPresentacionPlanilla']['year'], item['fechaPresentacionPlanilla']['month'], item['fechaPresentacionPlanilla']['day']))
        payroll.id_procesamiento = item['idProcesamiento']
        payroll.aporte_lab_ivm = item['aporteLabIVM']
        payroll.grupo_recepcion = item['grupoRecepcion']
        payroll.aporte_pat_fsv = item['aportePatFSV']
        payroll.complementaria = item['complementaria']
        payroll.correlativo_empleado = item['correlativoEmpleado']
        payroll.dias_vacacion = item['diasVacacion']
        payroll.tipo_procesamiento = item['tipoProcesamiento']
        payroll.save
      end
    end

    desc 'Carga las tablas payrolls desde el csv'
    task load_csv: [:environment] do
      require 'csv'

      #Ofcia::Payroll.destroy_all

      i = 0
      csv_path = "#{Rails.root.to_s}/db/data-isss-last.csv"
      CSV.foreach(csv_path, headers: false, encoding:'iso-8859-1:utf-8') do |row|
        i = i + 1
        begin
          nit_with_zeros = row[2].rjust(14, "0")

          activity = Ofcia::PayrollEconomicActivity.where(name: row[1].try(:strip)).first_or_create
          patron = activity.payroll_patrons.where(nit: nit_with_zeros).first_or_create(name: row[3].try(:strip))

          payroll = patron.payrolls.create(
            period: row[0],
            period_date: Date.new(row[0][0..3].to_i,row[0][4..5].to_i,1),
            total_up: row[4],
            amount_up: row[5].gsub(',', '.').to_f,
            total_down: row[6],
            amount_down: row[7].gsub(',', '.').to_f,
            total_pensioned: row[8],
            total_contributors: row[9],
            total: row[10],
            amount_total: row[11].gsub(',', '.').to_f
          )
        rescue
          puts "Error en la línea #{i}"
        end
      end
    end

    desc 'Set parents to patrons'
    task fill_parents: [:environment] do
      require 'csv'
      csv_path = "#{Rails.root.to_s}/db/patronos.csv"
      CSV.foreach(csv_path, headers: true) do |row|
        if row[5].present?
          #puts "#{row[2]} con ID #{row[1]}, tiene como parent a #{row[5]} con ID #{row[4]}"
          obj = Ofcia::PayrollPatron.where(id: row[1]).first
          if obj
            obj.update_column(:payroll_patron_id, row[4])
            obj.update_column(:payroll_economic_activity_id, 1) # ID quemado de ministerios
          end
        end
      end

    end


    desc 'Carga de bienestar magisterial'
    task load_isbm: [:environment] do
      require 'csv'
      i = 0
      csv_path = "#{Rails.root.to_s}/db/bienestar.csv"
      CSV.foreach(csv_path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
        i = i + 1
        begin
          nit_with_zeros = row[2].rjust(14, "0")

          activity = Ofcia::PayrollEconomicActivity.where(name: 'Bienestar Magisterial').first_or_create
          patron = activity.payroll_patrons.where(nit: '00000000000000').first_or_create(name: 'Bienestar Magisterial')

          payroll = patron.payrolls.create(
            period: "#{row[1]}#{row[0].to_s.rjust(2, '0')}",
            period_date: Date.new(row[1].to_i,row[0].to_i,1),
            total: row[2],
            amount_total: row[3].gsub(',', '.').to_f
          )
        rescue
          puts "Error en la línea #{i}"
        end
      end
    end

  end
end
