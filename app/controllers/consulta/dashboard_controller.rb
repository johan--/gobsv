class Consulta::DashboardController < ConsultaController
  layout 'consulta'

  def index
    @events = CnsEvent.limit(3).decorate rescue nil
    @articles = CnsArticle.limit(3).decorate rescue nil
    @categories = CnsCategory.all
    begin
      tclient = TwitterBot.client
      @tweets = tclient.search('#ConsultaPQD', type: 'recent').take(6)
    rescue
      nil
    end
  end

  private
    def timelines
      @timelines ||= CnsTimeline.order(:timeline_date)
    end
    helper_method :timelines
end
