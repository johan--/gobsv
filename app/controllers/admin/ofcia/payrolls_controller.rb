class Admin::Ofcia::PayrollsController < Admin::OfciaController
  def index
    @payroll = ::Ofcia::Payroll.new
    @enconomic_activities = ::Ofcia::PayrollEconomicActivity.order(:name)
    ### Prepare params[:q] vars
    if params[:q]
      # if economic activity is present, we clear the params
      if params[:q][:payroll_patron_payroll_economic_activity_id_in].present?
        params[:q][:payroll_patron_payroll_economic_activity_id_in].reject!{|v| v.blank?}
      end
    end
    if params[:dates].present?
      batches    = params[:dates].split(' - ')
      @start_date = Date.parse batches.first
      @end_date   = Date.parse batches.last
      params[:q].merge!(period_date_gteq: @start_date)
      params[:q].merge!(period_date_lteq: @end_date)
    end
    ### Do the search
    @q = ::Ofcia::Payroll.includes(payroll_patron: :payroll_economic_activity)
    ### grouping
    if (params[:filter].to_s || 'anual') == 'anual'
      #@q = @q.select("to_char(period_date, 'YYYY'), payroll_patron_id, SUM(total), SUM(amount_total)").group("to_char(period_date, 'YYYY'), payroll_patron_id")
    else
      #@q = @q.select("to_char(period_date, 'YYYY'), payroll_patron_id, SUM(total), SUM(amount_total)").group("to_char(period_date, 'YYYY'), payroll_patron_id")
    end
    @q = @q.ransack(params[:q])
    @payrolls = @q.result
  end


  def create
    @payroll = ::Ofcia::Payroll.new item_params
    @payroll.dates_from_range!

    @enconomic_activities = ::Ofcia::PayrollEconomicActivity
                            .where(id: @payroll.economic_activity_ids)
                            .order(:name)

    @header = @enconomic_activities.map(&:name)

    if %w(total amount_total).include?(@payroll.field)
      @matrix = build_matrix(
        @payroll.field,
        @payroll.start_date,
        @payroll.end_date,
        @enconomic_activities.map(&:id)
      )
    elsif %w(total_avg amount_total_avg).include?(@payroll.field)
      @matrix = build_matrix_avg(
        @payroll.field,
        @payroll.start_date,
        @payroll.end_date,
        @enconomic_activities.map(&:id)
      )
    elsif %w(percapita_month percapita_year).include?(@payroll.field)
      @matrix = build_matrix_pc(
        @payroll.field,
        @payroll.start_date,
        @payroll.end_date,
        @enconomic_activities.map(&:id)
      )
    else
      @matrix = build_matrix_all(
        @payroll.field,
        @payroll.start_date,
        @payroll.end_date,
        @enconomic_activities.map(&:id)
      )
    end

    render json: { header: @header, matrix: @matrix }
  end

  def item_params
    params
      .require(:ofcia_payroll)
      .permit(
        :dates,
        :field,
        economic_activity_ids: []
      )
  end

  helper_method :filters
  def filters
    [
      # ['Empleos (Mensual)', :total],
      # ['Empleos (Promedio anual)', :total_avg],
      # ['Salario (Mensual)', :amount_total],
      # ['Salario (Promedio anual)', :amount_total_avg],
      # ['Per cápita (Mensual)', :percapita_month],
      # ['Per cápita (Anual)', :percapita_year],
      # ['Todos los campos (Mensual)', :all_month],
      # ['Todos los campos (Anual)', :all_year]
      ['Promedio anual', :anual],
      ['Promedio mensual', :mensual]
    ]
  end

  private

  def build_matrix(field, start_date, end_date, economic_activity_ids)
    matrix = ::Ofcia::Payroll
             .matrix_dates(start_date, end_date)
             .matrix(field, economic_activity_ids)
             .to_a
             .map(&:attributes)
             .map(&:values)
             .map { |i| i.map { |v| v.nil? ? 0 : v } }

    ##
    # Rails returns id as first attribute
    matrix.map(&:shift)
    matrix
  end

  def build_matrix_avg(field, start_date, end_date, economic_activity_ids)
    matrix = ::Ofcia::Payroll
             .matrix_dates(start_date, end_date)
             .matrix_avg(field, economic_activity_ids)
             .to_a
             .map(&:attributes)
             .map(&:values)
             .map { |i| i.map { |v| v.nil? ? 0 : v } }

    ##
    # Rails returns id as first attribute
    matrix.map(&:shift)
    matrix
  end

  def build_matrix_pc(grouped_by, start_date, end_date, economic_activity_ids)
    matrix = ::Ofcia::Payroll
             .matrix_dates(start_date, end_date)
             .matrix_pc(grouped_by, economic_activity_ids)
             .to_a
             .map(&:attributes)
             .map(&:values)
             .map { |i| i.map { |v| v.nil? ? 0 : v } }

    ##
    # Rails returns id as first attribute
    matrix.map(&:shift)
    matrix
  end

  def build_matrix_all(grouped_by, start_date, end_date, economic_activity_ids)
    matrix = ::Ofcia::Payroll
             .matrix_dates(start_date, end_date)
             .matrix_all(grouped_by, economic_activity_ids)
             .to_a
             .map(&:attributes)
             .map(&:values)
             .map { |i| i.map { |v| v.nil? ? 0 : v } }

    ##
    # Rails returns id as first attribute
    matrix.map(&:shift)
    matrix
  end
end
