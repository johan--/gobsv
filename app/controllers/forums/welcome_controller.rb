class Forums::WelcomeController < ForumsController
  def index
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
    @gender = params[:gender].to_s
  
    #Constantes
    @esquema_actual = 11.27
    @porcentaje_esquema_actual = 12.5 #cambiar nombre variable
    @supuesto_rentabilidad_actual = 0.033 #3.3%
    @tasa_contribucion_cuenta_reforma = 0.111 #11.1%
    @comision_seguros_reforma = 0.019 #1.9%
    @dos_salarios_minimos = 251.7*2
    @capital_tecnico_necesario = @gender == "male" ? 11.2718536995587 : 13.4152856651179
  
    #Esquema Actual
    @valor_1a = 0.108*12*@salario
    @rentabilidad_neta_actual = @supuesto_rentabilidad_actual*@salario
    @valor_final_actual = @valor_1a
    @rentabilidad_neta_en_el_tiempo_actual = @rentabilidad_neta_actual
    25.times do
      @rentabilidad_neta_en_el_tiempo_actual = @valor_final_actual * @supuesto_rentabilidad_actual
      @valor_final_actual = @valor_final_actual + @valor_1a + @rentabilidad_neta_en_el_tiempo_actual
    end
    @pension_minima_con_subsidio = (@valor_final_actual / (@capital_tecnico_necesario*@porcentaje_esquema_actual)) < 207.6 ? 207.6 : @valor_final_actual / (@capital_tecnico_necesario*@porcentaje_esquema_actual)
    @pension_segun_ahorros_actual = @valor_final_actual / (@capital_tecnico_necesario*@porcentaje_esquema_actual)
    @comisiones_pagadas_a_afp_actual = 0.022*@salario*12*25
    @anios_de_pension_a_recibir = ((@valor_final_actual/@pension_minima_con_subsidio)/@porcentaje_esquema_actual).round(0)
    @anios_financiaria_estado = @gender == "male" ? 17-@anios_de_pension_a_recibir : 29-@anios_de_pension_a_recibir
    @porcentaje_respecto_salario_actual = @pension_segun_ahorros_actual/@salario
    @financiamiento_asumido_por_estado_actual = @anios_financiaria_estado * 207.6 * @porcentaje_esquema_actual
    @dinero_para_gobierno_actual = (@financiamiento_asumido_por_estado_actual / @valor_final_actual).round(1)

    #Esquema segun Reforma
    @valor_1r = @salario <= @dos_salarios_minimos ? 0 : (@salario - @dos_salarios_minimos)*@tasa_contribucion_cuenta_reforma
    @rentabilidad_neta_reforma = @supuesto_rentabilidad_actual * @valor_1r
    @valor_final_reforma = @valor_1r
    @rentabilidad_neta_en_el_tiempo_reforma = @rentabilidad_neta_reforma
    25.times do
      @valor_final_reforma = @valor_final_reforma + @valor_1r + @rentabilidad_neta_en_el_tiempo_reforma
      @rentabilidad_neta_en_el_tiempo_reforma = @valor_final_reforma * @supuesto_rentabilidad_actual
    end
    @pension_aproximada_reforma = (@valor_final_reforma / @capital_tecnico_necesario)+207.6
    @comisiones_pagadas_a_afp_reforma = @salario > @dos_salarios_minimos ? ((@comision_seguros_reforma*12*25*(@salario-@dos_salarios_minimos))+(0.01*@dos_salarios_minimos*12*25)) : (0.01*@salario*12*25)
    @porcentaje_respecto_salario_reforma = @pension_aproximada_reforma / @salario
    @financiamiento_asumido_por_estado_reforma = @gender == "male" ? 17*207.6*@porcentaje_esquema_actual : 29*207.6*@porcentaje_esquema_actual
    @dinero_para_gobierno_reforma = (@financiamiento_asumido_por_estado_reforma / @valor_final_actual).round(1)
  end

end
