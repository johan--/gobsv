class Consulta::DashboardController < ConsultaController
  layout 'consulta'

  def index
    @events = CnsEvent.limit(3).decorate rescue nil
    @articles = CnsArticle.limit(3).decorate rescue nil
    twclient = TwitterBot.client
    @tweets = twclient.search('#ConsultaCiudadana', type: 'recent').take(6)
  end

  def show
    @event = CnsEvent.find(params[:id])
  end
end
