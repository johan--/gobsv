class Employments::JobsController < EmploymentsController
  respond_to :html, :js
  before_action :authenticate_user!, only: [:apply]
  before_action :define_params
  before_action :get_job, except: [:index]
  before_action :prepare_breadcrumb

  def index
    params[:q][:plaza_state_id_in] = ['2'] unless params[:q][:plaza_state_id_in].present?
    @search = Employments::PublicCompetition
      .active
      .order(created_date: :desc)
    @search = @search.available if params[:q][:plaza_state_id_in].include?('2')
    @jobs = @search
      .ransack(params[:q])
      .result(distinct: true)
      .paginate(page: params[:page], per_page: 5)
    @search = Employments::PublicCompetition
      .select(:institution_id, :institution_name, :institution_code)
      .active
      .uniq(:institution_id)
    @search = @search.available if params[:q][:plaza_state_id_in].include?('2')
    @institutions = @search
      .ransack(plaza_state_id_in: params[:q][:plaza_state_id_in])
      .result(distinct: true)
  end

  def show
    set_meta_tags og: {
                      title: @job.post_name,
                      description: @job.institution_name,
                      url: employments_job_url(@job),
                      image: 'http://www.empleospublicos.gob.sv' + view_context.image_path('employments/cv-girl.png')
                    }
  end

  private
    def define_params
      params[:q] ||= {}
    end
    def get_job
      @job = Employments::PublicCompetition.active.find(params[:id])
      redirect_to employments_jobs_url and return unless @job
    end
    def prepare_breadcrumb
      add_breadcrumb 'Inicio', employments_root_url
      add_breadcrumb 'Empleos disponibles', employments_jobs_url
      add_breadcrumb @job.post_name if @job
    end
end
