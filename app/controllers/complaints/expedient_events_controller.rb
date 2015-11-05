class Complaints::ExpedientEventsController < ComplaintsController

  def create
    event = expedient.events.new(item_params)
    case expedient.status
    when 'new'
      event.status = 'process'
    when 'process'
      event.status = 'closed'
    end
    event.admin_id = current_admin.id
    @success = event.save
    @errors = event.errors.messages.to_json.html_safe unless @success
  end

  def expedient
    @expedient ||= params[:expedient_id] ? Complaints::Expedient.find(params[:expedient_id]) : nil
  end
  helper_method :expedient

  def item_params
    params.require(:complaints_expedient_event).permit(
      :justification,
      :start_at,
      :status
    )
  end

end
