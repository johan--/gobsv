class Admin::Ofcia::PayrollsController < Admin::OfciaController
  def index
    @payroll = ::Ofcia::Payroll.new
    @enconomic_activities = ::Ofcia::PayrollEconomicActivity.order(:name)
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
    else
      @matrix = build_matrix_avg(
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
end
