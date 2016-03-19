class Complaints::ExpedientManagementsController < ComplaintsController
  def create
    @management = expedient.managements.new(item_params)
    @management.admin_id = current_admin.id
    @success = @management.save
    if @success
      @management.asset_ids = item_params['asset_ids'].split(',') if item_params['asset_ids']
    else
      @errors = @management.errors.messages.to_json.html_safe
    end
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
