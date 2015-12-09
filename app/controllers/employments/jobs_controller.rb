class Employments::JobsController < EmploymentsController
  respond_to :html, :js

  def index
    @jobs = Employments::PublicCompetition.valid.ransack(params[:q]).result(distinct: true).paginate(page: params[:page])
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", nil
  end

  def show
    @job = Employments::PublicCompetition.find(params[:id])
    puts @job.inspect
    respond_to do |format|
      format.js
    end
  end

end
