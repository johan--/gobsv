class Admin::Ofcia::PayrollViewsController < Admin::OfciaController
  def index
    @payroll_view = ::Ofcia::PayrollView.new

    @sectors = ::Ofcia::PayrollSector
               .has_payrolls.order(:name)

    @economic_activity_groups = ::Ofcia::PayrollEconomicActivityGroup
                                .order(:name)

    @economic_activities = ::Ofcia::PayrollView
                           .select(:economic_activity_id)
                           .select(:economic_activity_name)
                           .distinct
                           .order(:economic_activity_name)

    @years = ::Ofcia::PayrollView
             .select(:year)
             .distinct
             .order(:year)
             .pluck(:year)

    @months = (1..12).to_a
  end

  def create
    @payroll_view = ::Ofcia::PayrollView.new(item_params)
    @payroll_view.rows!
    render json: @payroll_view.rows
  end

  def item_params
    params.require(:ofcia_payroll_view).permit(
      :sector_id,
      :economic_activity_group_id,
      :economic_activity_id,
      :year,
      :month
    )
  end
end
