class Consulta::DashboardController < ConsultaController
  layout 'consulta'

  def index
    @events = CnsEvent.limit(3).decorate rescue nil
    @articles = CnsArticle.limit(3).decorate rescue nil

    begin
      tclient = TwitterBot.client
      @tweets = tclient.search('#ConsultaPQD', type: 'recent').take(6)
    rescue
      nil
    end
  end

  def show
    @event = CnsEvent.find(params[:id])
  end

  private
    def timelines
      @timelines ||= CnsTimeline.order(:timeline_date)
    end
    helper_method :timelines
end
