class Consulta::CnsEventsController < ConsultaController
  def index 
    @events = CnsEvent.active.order("event_date ASC").decorate
    show_breadcrumbs
  end

  def show
    show_breadcrumbs(event)
  end

  private
    def event
      @event ||= params[:id] ? CnsEvent.find(params[:id]) : CnsEvent.new
    end
    helper_method :event

    def show_breadcrumbs(event=nil)
      add_breadcrumb I18n.t('layouts.consulta.home'), root_path
      add_breadcrumb I18n.t('layouts.consulta.events'), consulta_cns_events_path
      add_breadcrumb event.name, consulta_cns_event_path(event) unless event.nil?
    end
end
