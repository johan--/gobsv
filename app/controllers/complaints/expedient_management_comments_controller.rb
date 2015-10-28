class Complaints::ExpedientManagementCommentsController < ComplaintsController
  def create
    @management = Complaints::ExpedientManagement.find(params[:expedient_management_id])
    comment = @management.comments.new(item_params)
    comment.admin_id = current_admin.id
    @success = comment.save
    @errors = comment.errors.messages.to_json.html_safe unless @success
  end

  def item_params
    params.require(:complaints_expedient_management_comment).permit(
      :comment
    )
  end
end
