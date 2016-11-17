class Indicators::WelcomeController < IndicatorsController

  def index
    @indicator_categories = ::Ind::Category.order :name
  end

end