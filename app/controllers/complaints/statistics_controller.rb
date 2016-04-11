class Complaints::StatisticsController < ComplaintsController

  def index
    if current_admin.admin?
      @my_expedients = ::Complaints::Expedient
    elsif current_admin.oficial?
      @my_expedients = ::Complaints::Expedient.where(institution_id: current_admin.institution_id)
    else
      @my_expedients = ::Complaints::Expedient.newer.joins(:managements).where("complaints_expedient_managements.assigned_ids @> '{?}'", current_admin.id)
    end
  end

end
