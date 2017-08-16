class Forums::WelcomeController < ForumsController
  layout 'calculator'

  def index
=begin
    @main = Forum::Theme.active.main.first
    params[:q] ||= {}
    params[:q].reject!{|_, v| v.blank?}
    if params[:q][:year_eq].present?
      params[:q].merge!(entry_at_gteq: Date.new(params[:q][:year_eq].to_i, 1, 1))
      params[:q].merge!(entry_at_lteq: Date.new(params[:q][:year_eq].to_i, 12, 31))
    end
    if request.xhr? || request.format.js?
      @entries = @main.entries.ransack(params[:q]).result(distinct: true).paginate(page: params[:page], per_page: 5)
    else
      if @main
        @entries = @main.entries.ransack(params[:q]).result(distinct: true).paginate(page: params[:page], per_page: 5)
        @years = @main.entries.pluck(:entry_at).map{|x| x.year}.uniq
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
=end
  end

  def download
    @main = Forum::Theme.active.main.first
    if @main.asset.present?
      @main.update_column(:asset_downloads, @main.asset_downloads + 1)
      file_location = @main.asset.path
      send_file file_location,
        :filename => @main.asset_file_name,
        :type => @main.asset_content_type,
        :disposition => 'inline'
    else
      redirect_to forums_root_url and return
    end
  end

  def calculator
    #Params
    @salario = params[:wage].to_f.abs rescue 0
    @gender  = params[:gender].to_s

    #Constantes
    @porcentaje_esquema_actual        = 12.5 #cambiar nombre variable
    @porcentaje_cotizacion_actual     = 0.108 #10.8%
    @supuesto_rentabilidad_actual     = 0.04 #4%
    @tasa_contribucion_cuenta_reforma = 0.135 #13.5%
    @comision_seguros_reforma         = 0.019 #1.9%
    @dos_salarios_minimos             = 251.7*2
    @capital_tecnico_necesario        = @gender == "male" ? 13.5031464992298 : 16.7509110869664
    @densidad_cotizacion              = 0.75
    @anios_a_cotizar                  = 35
    @porcentaje1_propuesta_afp        = 0.08 # 8%
    @porcentaje2_propuesta_afp        = 0.085 # 8.5%
    @porcentaje3_propuesta_afp        = 0.09 # 9%

    #Otras variables
    @promedio_salario                 = 0
    @valor_final_actual               = 0
    @valor_final_reforma              = 0
    @valor_final_asafondos            = 0

    @salario_actual = @salario
    (1..(@anios_a_cotizar*12)).each do |i|
      if((i%12)!=0)
        @salario_actual = @salario_actual
      else
        @salario_actual = @salario_actual*(1+0.02)
      end
      @promedio_salario = @promedio_salario + @salario_actual

      @var = 35*12-i
      @var2 = @salario_actual*((1+@supuesto_rentabilidad_actual/12)**@var)

      #Esquema Actual
      @valor_sistema_actual = @var2*@porcentaje_cotizacion_actual*@densidad_cotizacion
      @valor_final_actual = @valor_final_actual + @valor_sistema_actual

      #Esquema segun propuesta gobierno
      @valor_propuesta_gob = @var2*@tasa_contribucion_cuenta_reforma*@densidad_cotizacion
      @valor_final_reforma = @valor_final_reforma + @valor_propuesta_gob

      #Esquema segun propuesta Asafondos
      @var2_percentage = (i >= 1 && i <= 120) ? @porcentaje1_propuesta_afp : (i >= 120 && i <= 240) ? @porcentaje2_propuesta_afp : @porcentaje3_propuesta_afp
      @constante_desconocida = (i >= 1 && i <= 120) ? 300 : (i >= 120 && i <= 240) ? 180 : 0
      @var2_alt = @salario_actual*((1+@supuesto_rentabilidad_actual/12)**(@var-@constante_desconocida))
      @valor_propuesta_afp = @var2_alt*@var2_percentage*@densidad_cotizacion
      @valor_final_asafondos = @valor_final_asafondos + @valor_propuesta_afp
    end

    @promedio_salario = @promedio_salario / 300

    #Esquema actual
    @pension_segun_ahorros_actual = @valor_final_actual / (@capital_tecnico_necesario*@porcentaje_esquema_actual)
    @pension_minima_con_subsidio = @pension_segun_ahorros_actual < 207.6 ? 207.6 : @pension_segun_ahorros_actual
    @comisiones_pagadas_a_afp_actual = 0.022*@salario*12*@anios_a_cotizar*@densidad_cotizacion

    @anios_de_pension_a_recibir = ((@valor_final_actual/@pension_minima_con_subsidio)/@porcentaje_esquema_actual).round(0)
    @anios_financiaria_estado = @gender == "male" ? 17-@anios_de_pension_a_recibir : 29-@anios_de_pension_a_recibir
    @porcentaje_respecto_salario_actual = @pension_segun_ahorros_actual/@salario
    @financiamiento_asumido_por_estado_actual = @anios_financiaria_estado * 207.6 * @porcentaje_esquema_actual
    @dinero_para_gobierno_actual = (@financiamiento_asumido_por_estado_actual / @valor_final_actual).round(1)
    @porcentaje_ahorro_comision_actual = ((@comisiones_pagadas_a_afp_actual / @valor_final_actual) * 100).round(2)

    #Esquema segun propuesta gobierno
    @pension_aproximada_reforma = @valor_final_reforma / (@capital_tecnico_necesario*12.5 )
    @comisiones_pagadas_a_afp_reforma = 0.015*@anios_a_cotizar*12*@densidad_cotizacion*@salario
    @porcentaje_respecto_salario_reforma = @pension_aproximada_reforma / @salario
    @financiamiento_asumido_por_estado_reforma = @gender == "male" ? 17*207.6*@porcentaje_esquema_actual : 29*207.6*@porcentaje_esquema_actual
    @dinero_para_gobierno_reforma = (@financiamiento_asumido_por_estado_reforma / @valor_final_actual).round(1)
    @porcentaje_ahorro_comision_reforma = ((@comisiones_pagadas_a_afp_reforma / @valor_final_reforma) * 100).round(2)

    #Esquema segun propuesta de Asafondos
    @pension_aproximada_asafondos = -pmt((@supuesto_rentabilidad_actual/12), (20*12), @valor_final_asafondos)
    @subsidio_gobierno = @pension_aproximada_asafondos >= 207.6 ? 0 : 207.6 - @pension_aproximada_asafondos
    @pension_final_asafondos = @pension_aproximada_asafondos + @subsidio_gobierno
    @comisiones_pagadas_a_afp_asafondos = 0.02*@anios_a_cotizar*12*@densidad_cotizacion*@salario
    @porcentaje_ahorro_comision_asafondos = ((@comisiones_pagadas_a_afp_asafondos / @valor_final_asafondos) * 100).round(2)

    render :layout => 'calculator'

  end

  #FORMULAS FINANCIERAS
  def pmt(rate, nper, pv, fv=0, type=0)
   ((-pv * pvif(rate, nper) - fv ) / ((1.0 + rate * type) * fvifa(rate, nper)))
  end

  def pow1pm1(x, y)
     (x <= -1) ? ((1 + x) ** y) - 1 : Math.exp(y * Math.log(1.0 + x)) - 1
   end

   def pow1p(x, y)
     (x.abs > 0.5) ? ((1 + x) ** y) : Math.exp(y * Math.log(1.0 + x))
   end

  def pvif(rate, nper)
    pow1p(rate, nper)
  end

  def fvifa(rate, nper)
    (rate == 0) ? nper : pow1pm1(rate, nper) / rate
  end


end
