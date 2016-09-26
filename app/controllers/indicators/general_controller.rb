class Indicators::GeneralController < IndicatorsController

  def index
    @indicator_categories = ::Ind::Category.order :name
    @indicator = ::Ind::Note.find 2
  end

  def show
    
  end

end