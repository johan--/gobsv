class Admin::Paa::ReportsController < AdminController
  def index
  end

  def savings_by_financial_source_unaudited
    @fsources   = ::Paa::FinancialSource.all
    @categories = ::Paa::Saving::SAVING_CATEGORY_UNAUDITED
    respond_to do |format|
      format.xls 
    end
  end

  def savings_by_financial_source_audited
    @fsources   = ::Paa::FinancialSource.all
    @categories = ::Paa::Saving::SAVING_CATEGORY_AUDITED
    respond_to do |format|
      format.xls 
    end
  end

  def funds_generated_by_the_institutions_of_the_executive_organ
    @fsources     = ::Paa::FinancialSource.all
    @categories   = ::Paa::Saving::SAVING_CATEGORY_AUDITED
    @institutions = Institution.order :name
    respond_to do |format|
      format.xls 
    end
  end

end
