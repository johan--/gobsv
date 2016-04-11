class Complaints::ExpedientManagementsController < ComplaintsController
  def create
    @management = expedient.managements.new(item_params)
    @management.admin_id = current_admin.id
    @management.status = 'process'
    @success = @management.save
    if @success
      @management.asset_ids = item_params['asset_ids'].split(',') if item_params['asset_ids']
      # Creamos un evento "en proceso" de la gestión
      @management.events.create(status: 'process', admin_id: current_admin.id, start_at: Time.current, justification: 'Inicio del proceso')
    else
      @errors = @management.errors.messages.to_json.html_safe
    end
  end

  def destroy
    @management = ::Complaints::ExpedientManagement.find(params[:id])
    @management.destroy
  end

  def expedient
    @expedient ||= params[:expedient_id] ? Complaints::Expedient.find(params[:expedient_id]) : nil
  end
  helper_method :expedient

  def item_params
    params.require(:complaints_expedient_management).permit(
      :kind,
      :comment,
      :asset_ids,
      :assigned_ids => []
    )
  end
end
