class Admin::Paa::ReportsController < AdminController
  def index
  end

  def savings_by_financial_source
    respond_to do |format|
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

end
