class Admin::Ofcia::PayrollsController < Admin::OfciaController
  def model
    ::Ofcia::Payroll
  end

  def table_columns
    %w(periodo fecha_presentacion_planilla id_procesamiento)
  end

  def init_form
    @payroll_observation_codes = ::Ofcia::PayrollObservationCode.order(:name)
    @payroll_statuses = ::Ofcia::PayrollStatus.order(:name)
    @payroll_types = ::Ofcia::PayrollType.order(:name)
  end

  def reports
    @scope1 = ::Ofcia::Payroll
    if params.key?(:period1)
      @period_1 = params2period(params[:period1])
      @scope1   = @scope1.year(@period_1[:year])   unless @period_1[:year].nil?
      @scope1   = @scope1.month(@period_1[:month]) unless @period_1[:month].nil?
    end

    @scope2 = ::Ofcia::Payroll
    if params.key?(:period2)
      @period_2 = params2period(params[:period2])
      @scope2   = @scope2.year(@period_2[:year])   unless @period_2[:year].nil?
      @scope2   = @scope2.month(@period_2[:month]) unless @period_2[:month].nil?
    end

    @sectors = ::Ofcia::PayrollSector.has_payrolls.order(:name)
  end

  def item_params
    params.require(:ofcia_payroll).permit(
      :periodo,
      :id_causa_complemento,
      :tasa_cotiz_lab_ivm,
      :impresa,
      :tipo_mora,
      :maximo_cotizable_fsv,
      :correlativo_centro_trabajo,
      :cambio_nota_detalle,
      :id_usuario,
      :correlativo_original_migracion,
      :id_codigo_observacion,
      :id_sucursal,
      :aporte_pat_ivm,
      :horas,
      :tasa_cotiz_pat_ivm,
      :tasa_cotiz_pat_fsv,
      :maximo_cotizable,
      :aporte_patronal,
      :monto_vacacion,
      :monto_salario,
      :id_tipo_pago_planilla,
      :aporte_total_ivm,
      :aporte_total,
      :id_estado_planilla,
      :tasa_cotiz_laboral,
      :monto_pago_adicional,
      :id_tipo_planilla,
      :aporte_total_fsv,
      :aporte_lab_fsv,
      :cambio_nota,
      :aporte_laboral,
      :tasa_cotiz_patronal,
      :no_afiliacion_trabajador,
      :mecanizada,
      :tasa_cotiz_lab_fsv,
      :dias,
      :no_patronal,
      :maximo_cotizable_ivm,
      :fecha_presentacion_planilla,
      :id_procesamiento,
      :aporte_lab_ivm,
      :grupo_recepcion,
      :aporte_pat_fsv,
      :complementaria,
      :correlativo_empleado,
      :dias_vacacion,
      :tipo_procesamiento
    )
  end

  def flatten_date(hash)
    hash.sort.map(&:last).map { |v| v.to_i.zero? ? nil : v.to_i }
  end

  def params2period(hash)
    v = flatten_date hash
    { year: v.first, month: v.second, day: v.last }
  end

  helper_method :period2string
  def period2string(period)
    return '- -' if period.nil?
    a = []
    a << period[:month] unless period[:month].nil?
    a << period[:year]  unless period[:year].nil?
    return '- -' if a.empty?
    a.join(' / ')
  end
end
