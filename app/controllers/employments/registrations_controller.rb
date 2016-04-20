class Employments::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  before_filter :prepare_search, :draw_breadcrumb

  layout 'user/login'

  # POST /resource 
  def create
    super do |resource|
      verify_recaptcha(model: resource, message: 'La verificación del reCAPTCHA es incorrecta, intente de nuevo.')
    end
  end

  private   
  
  def draw_breadcrumb
    add_breadcrumb 'Inicio', employments_jobs_url
    add_breadcrumb "Usuario"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :last_name)
  end
  
  def after_sign_up_path_for(resource)
    personal_resume_employments_resumes_url
  end

  def after_inactive_sign_up_path_for(resource) 
    employments_jobs_url
  end 

  def prepare_search
    @q = Employments::PublicCompetition.ransack(params[:q])
  end
end
