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
  end
end
