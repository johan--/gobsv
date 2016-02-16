class Employments::JobsController < EmploymentsController
  respond_to :html, :js

  def index
    params[:q] ||= {}
    params[:q][:plaza_state_id_eq] = 2 unless params[:q][:plaza_state_id_eq].present?
    @search = Employments::PublicCompetition
      .active
      .order(created_date: :desc)
    @search = @search.available if params[:q][:plaza_state_id_eq] == 2
    @jobs = @search
      .ransack(params[:q])
      .result(distinct: true)
      .paginate(page: params[:page], per_page: 5)
    if params[:q][:institution_id_eq].present?
      @institutions = Employments::PublicCompetition
        .active
        .select(:institution_id, :institution_name, :institution_code)
        .where(institution_id: params[:q][:institution_id_eq])
        .limit(1)
    else
      @institutions = Employments::PublicCompetition
        .select(:institution_id, :institution_name, :institution_code)
        .active
        .uniq(:institution_id)
        .ransack(params[:q])
        .result(distinct: true)
    end

    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Plazas y empleos", employments_jobs_url
  end

  def show
    params[:q] ||= {}
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
