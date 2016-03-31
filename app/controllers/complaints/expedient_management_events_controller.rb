class Complaints::ExpedientManagementEventsController < ComplaintsController
  def create
    @management = Complaints::ExpedientManagement.find(params[:expedient_management_id])
    event = @management.events.new(item_params)
    message = ""
    case @management.status
      when 'new'
        event.status = 'process'
        message = "#{current_admin.name} Se ha comunicado con el usuario, con la siguiente justificación: <p>#{event.justification}</p>"
      when 'process'
        event.status = 'closed'
        message = "#{current_admin.name} ha cerrado la gestión, con la siguiente justificación: <p>#{event.justification}</p><p>Cantidad de #{@management.kind_s.upcase} procesadas: #{event.weight}.</p>"
    end
    event.admin_id = current_admin.id
    @success = event.save
    if @success
      @management.status = event.status
      @management.weight = event.weight
      @management.save
      @management.comments.create(admin_id: current_admin.id, comment: message)
    end
    @errors = event.errors.messages.to_json.html_safe unless @success
  end

  def item_params
    params.require(:complaints_expedient_management_event).permit(
      :justification,
      :start_at,
      :status,
      :weight
    )
  end
end
