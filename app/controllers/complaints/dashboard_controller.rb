class Complaints::DashboardController < ComplaintsController
  def index
    #skip_authorization


    if current_admin.admin?
      @my_expedients = ::Complaints::Expedient
    elsif current_admin.oficial?
      @my_expedients = ::Complaints::Expedient.where(institution_id: current_admin.institution_id)
    else
      @my_expedients = ::Complaints::Expedient.newer.joins(:managements).where("complaints_expedient_managements.assigned_ids @> '{?}'", current_admin.id)
    end


    @process = @my_expedients.status('process').count
    @closed = @my_expedients.status('closed').count
    @last_managements = ::Complaints::ExpedientManagement.where(expedient_id: @my_expedients.pluck(:id)).closed.limit(4).order(updated_at: :desc)
    @new_expedients = @my_expedients.status('new')
  end
end
