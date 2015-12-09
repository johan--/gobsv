class Employments::JobsController < EmploymentsController
  respond_to :html, :js

  def index
    @jobs = Employments::PublicCompetition.valid.ransack(params[:q]).result(distinct: true).paginate(page: params[:page], per_page: 5)
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", nil
  end

  def show
    @job = Employments::PublicCompetition.find(params[:id])
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", employments_jobs_url
    add_breadcrumb @job.post_name
    respond_to do |format|
      format.js
      format.html
    end
  end

end
