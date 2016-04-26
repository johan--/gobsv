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

  def edit
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      flash[:notice] = 'Se ha actualizado su contraseña'
      sign_in @user, :bypass => true
      redirect_to personal_employments_resumes_path
    else
      flash[:notice] = 'No se pudo actualizar la información'
      render "edit"
    end    
  end

  private

  def draw_breadcrumb
    add_breadcrumb 'Inicio', employments_jobs_url
    add_breadcrumb "Usuario"
  end

  protected

  def user_params
     params.require(:user).permit(:password, :password_confirmation)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :last_name)
  end

  def after_sign_up_path_for(resource)
    personal_employments_resumes_url
  end

  def after_inactive_sign_up_path_for(resource)
    employments_jobs_url
  end

  def prepare_search
    @q = Employments::Plaza.ransack(params[:q])
  end
end
