class Consulta::DashboardController < ConsultaController
  layout 'consulta'

  def index
    @events = CnsEvent.limit(3).decorate rescue nil
    @articles = CnsArticle.limit(3).decorate rescue nil
  end

  def show
    @event = CnsEvent.find(params[:id])
  end
end
