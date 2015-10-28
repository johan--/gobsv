class Complaints::ExpedientManagementsController < ComplaintsController
  def create
    @management = expedient.managements.new(item_params)
    @management.admin_id = current_admin.id
    @success = @management.save
    @errors = @management.errors.messages.to_json.html_safe unless @success
  end

  def expedient
    @expedient ||= params[:expedient_id] ? Complaints::Expedient.find(params[:expedient_id]) : nil
  end
  helper_method :expedient

  def item_params
    params.require(:complaints_expedient_management).permit(
      :kind,
      :comment,
      :assigned_ids => []
    )
  end
end
