class Employments::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  before_filter :prepare_search, :draw_breadcrumb

  layout 'user/login'

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      self.resource.change_humanizer_question
      @errors = resource.errors.full_messages
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
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
    devise_parameter_sanitizer.for(:sign_up).push(:name, :last_name, :humanizer_answer, :humanizer_question_id)
  end

  def after_sign_up_path_for(resource)
    personal_employments_resumes_url
  end

  def after_inactive_sign_up_path_for(resource)
    verify_email_employments_pages_url
  end

  def prepare_search
    @q = Employments::Plaza.ransack(params[:q])
  end
end
