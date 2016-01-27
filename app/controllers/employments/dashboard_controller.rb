class Employments::DashboardController < EmploymentsController

  def index
    @publish_plazas = Employments::PublicCompetition.active.where.not(plaza_state_id: 1)
    @total_plazas = Employments::PublicCompetition.active.valid.count.to_s.rjust(4, '0')
    @last_plazas = Employments::PublicCompetition.active.valid.order(updated_date: :desc).limit(2)
    @institutions = Employments::PublicCompetition.select(:institution_id, :institution_name, :institution_code).active.valid.uniq(:institution_id)
  end
end
