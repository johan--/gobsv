class Indicators::GeneralController < IndicatorsController

  def index
    if params[:category].nil?
      redirect_to indicators_root_url and return
    end
    @indicator_category = ::Ind::Category.find(params[:category])
  end

  def show
    @indicator = ::Ind::Note.find params[:id]
  end

  def about
    
  end

end