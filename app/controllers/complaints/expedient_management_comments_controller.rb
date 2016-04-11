class Complaints::ExpedientManagementCommentsController < ComplaintsController
  def create
    @management = Complaints::ExpedientManagement.find(params[:expedient_management_id])
    comment = @management.comments.new(item_params)
    comment.admin_id = current_admin.id
    @success = comment.save
    if @success
      comment.asset_ids = item_params['asset_ids'].split(',') if item_params['asset_ids']
    else
      @errors = comment.errors.messages.to_json.html_safe unless @success
    end
  end

  def item_params
    params.require(:complaints_expedient_management_comment).permit(
      :comment,
      :asset_ids
    )
  end
end
