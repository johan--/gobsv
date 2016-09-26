class Indicators::GeneralController < IndicatorsController

  def index
    @indicator_categories = ::Ind::Category.order :name
  end

  def show
  	@indicator_categories = ::Ind::Category.order :name
    @indicator = ::Ind::Note.find params[:id]
  end

end