class Employments::JobsController < EmploymentsController

  def index
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", nil
  end

  def show
    #@job = Employments::PublicCompetition.find(params[:id])
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", employments_jobs_url
  end

end
