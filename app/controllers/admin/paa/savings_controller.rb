class Admin::Paa::SavingsController < Admin::PaaController

  def model
    ::Paa::Saving
  end

  def table_columns
    %w(institution_id created_at state financial_source_id)
  end

  def init_form
    @financial_sources = Paa::FinancialSource.order :name
    @institutions = Institution.order :name
  end

  def item_params
    params.require(:paa_saving).permit(
      :institution_id,
      :financial_source_id
    )
  end

end
