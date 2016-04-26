class Employments::JobsController < EmploymentsController
  respond_to :html, :js
  before_action :authenticate_user!, only: [:apply, :postulation]
  before_action :define_params
  before_action :get_job, except: [:index, :progress]
  before_action :prepare_breadcrumb
  before_filter :verify_cv, only: [:apply]

  def index
    params[:q][:plaza_state_id_in] = ['2'] unless params[:q][:plaza_state_id_in].present?
    @search = Employments::Plaza
      .active
      .order(created_date: :desc)
    @search = @search.available if params[:q][:plaza_state_id_in].include?('2')
    @jobs = @search
      .ransack(params[:q])
      .result(distinct: true)
      .paginate(page: params[:page], per_page: 5)
    @search = Employments::Plaza
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

  def apply
    @job_degrees = @job.plaza_degrees.indispensable
    @job_specialties = @job.plaza_specialties.indispensable
    @job_languages = @job.plaza_languages.indispensable
    @job_skills = @job.plaza_skills.indispensable
    @already_applied = current_user.plazas.pluck(:id).include?(@job.id)
    if request.post?
      @postulation = ::Employments::UserPostulation.new(params.require(:employments_user_postulation).permit(:terms))
      @postulation.user_id = current_user.id
      @postulation.plaza_id = @job.id
      if @postulation.save
        redirect_to postulation_employments_job_url(@job) and return
      else
        render :apply
      end
    else
      @postulation = ::Employments::UserPostulation.new
    end
  end

  def postulation
    @postulation = ::Employments::UserPostulation.where(user_id: current_user.id, plaza_id: @job.id).first
  end

  private
    def define_params
      params[:q] ||= {}
    end
    def get_job
      @job = Employments::Plaza.active.find(params[:id])
      redirect_to employments_jobs_url and return unless @job
    end
    def prepare_breadcrumb
      add_breadcrumb 'Inicio', employments_root_url
      add_breadcrumb 'Empleos disponibles', employments_jobs_url
      add_breadcrumb @job.post_name if @job
    end
    def verify_cv
      redirect_to personal_employments_resumes_url, notice: 'Por favor llene su cv antes de aplicar a una plaza' and return unless current_user.cv_valid?
    end
end
