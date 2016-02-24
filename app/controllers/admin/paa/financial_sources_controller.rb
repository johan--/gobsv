class Admin::Paa::FinancialSourcesController < Admin::PaaController

  def model
    ::Paa::FinancialSource
  end

  def table_columns
    %w(created_at name)
  end

  def init_form
  end

  def item_params
    params.require(:paa_financial_source).permit(
      :name
    )
  end

end
