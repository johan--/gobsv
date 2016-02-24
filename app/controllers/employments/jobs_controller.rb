class Employments::JobsController < EmploymentsController
  respond_to :html, :js
  before_action :define_params

  def index
    params[:q][:plaza_state_id_eq] = 2 unless params[:q][:plaza_state_id_eq].present?
    @search = Employments::PublicCompetition
      .active
      .order(created_date: :desc)
    @search = @search.available if params[:q][:plaza_state_id_eq].to_i == 2
    @jobs = @search
      .ransack(params[:q])
      .result(distinct: true)
      .paginate(page: params[:page], per_page: 5)
    @search = Employments::PublicCompetition
      .select(:institution_id, :institution_name, :institution_code)
      .active
      .uniq(:institution_id)
    @search = @search.available if params[:q][:plaza_state_id_eq].to_i == 2
    @institutions = @search
      .ransack(plaza_state_id_eq: params[:q][:plaza_state_id_eq])
      .result(distinct: true)

    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Plazas y empleos", employments_jobs_url
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

  private
    def define_params
      params[:q] ||= {}
    end

end
