class Employments::ResumesController < EmploymentsController
  respond_to :html, :js
  before_action :define_params

  def personal_resume
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Curriculum", employments_jobs_url
  end

  def show
    
  end

  private
    def define_params
      params[:q] ||= {}
    end

end
