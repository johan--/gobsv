class Employments::ResumesController < EmploymentsController
  respond_to :html, :js
  before_filter :prepare_search
  before_filter :authenticate_user!
  layout 'user/login'
  #protect_from_forgery except: :save

  def personal
    @user = current_user
    @disability_types = ::Employments::DisabilityType.all
    @disability_certifications = ::Employments::DisabilityCertification.all
    @countries = ::Employments::Country.all
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Curriculum"
  end

  def save
    @user = User.find current_user.id
    @user.assign_attributes item_params
    @user.update_cv = true
    @success = @user.save
    params = {}
    item_params = {}
    unless @success
      flash[:notice] = 'No se pudo actualizar la información'
      @errors = @user.errors.full_messages
      @disability_types = ::Employments::DisabilityType.all
      @disability_certifications = ::Employments::DisabilityCertification.all
      @countries = ::Employments::Country.all
      render :personal
    else
      ::SynchronizeUsersJob.perform_later(@user)
    end
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Curriculum", personal_employments_resumes_url
    add_breadcrumb "Actualizado"
  end

  def specialties
    @specialties = ::Employments::Specialty.active.order(:esp_name)
    @specialties = @specialties.where(gra_code: params[:gra_code]) if params[:gra_code].present?
  end

  def item_params
    params.require(:user).permit(
      :name,
      :last_name,
      :email,
      :gender,
      :birthday,
      :status,
      :phone,
      :alt_phone,
      :document_type,
      :document_number,
      :tax_id,
      :nationality,
      :status,
      :user_created,
      :user_edited,
      :treatment,
      :address,
      :country_id,
      references_attributes: [:id, :name, :charge, :address, :phone, :kind, :_destroy],
      specialties_attributes: [:id, :country_id, :gra_code, :esp_code, :institution_name, :certificate, :start_at, :end_at, :_destroy],
      trainings_attributes: [:id, :institution_name, :name, :description, :place, :duration, :year, :_destroy],
      work_experiences_attributes: [:id, :sector, :country_id, :institution_name, :charge, :description, :start_at, :end_at, :active, :_destroy],
      languages_attributes: [:id, :name, :read, :write, :speak, :_destroy],
      disabilities_attributes: [:id, :disability_type_id, :disability_certification_id, :_destroy],
      skills_attributes: [:id, :name, :_destroy]
    )
  end

  protected

  def prepare_search
    @q = Employments::Plaza.ransack(params[:q])
  end

end
