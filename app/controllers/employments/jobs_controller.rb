class Employments::JobsController < EmploymentsController
  respond_to :html, :js

  def index
    @jobs = Employments::PublicCompetition.active.valid.order(created_date: :desc).ransack(params[:q]).result(distinct: true).paginate(page: params[:page], per_page: 5)
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", nil
  end

  def show
    @job = Employments::PublicCompetition.active.find(params[:id])
    redirect_to employments_jobs_url and return unless @job
    set_meta_tags og: {
                      title: @job.post_name,
                      description: @job.institution_name,
                      url: employments_job_url(@job),
                      image: 'http://www.empleospublicos.gob.sv' + view_context.image_path('employments/cv-girl.png')
                    }
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", employments_jobs_url
    add_breadcrumb @job.post_name
  end


  def contact
    @job = Employments::PublicCompetition.active.find(params[:id])
    redirect_to employments_jobs_url and return unless @job
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Empleos disponibles", employments_jobs_url
    add_breadcrumb @job.post_name
  end

end