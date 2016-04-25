class Employments::DashboardController < EmploymentsController

  def index
    params[:q] ||= {}
    @publish_plazas = Employments::Plaza.where(active: true).where.not(plaza_state_id: 1)
    @total_plazas = Employments::Plaza.active.available.count.to_s.rjust(4, '0')
    @last_plazas = Employments::Plaza.active.available.order(updated_date: :desc).limit(2)
    @institutions = Employments::Plaza.select(:institution_id, :institution_name, :institution_code).active.available.uniq(:institution_id)
  end
end
