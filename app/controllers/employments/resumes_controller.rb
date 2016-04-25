class Employments::ResumesController < EmploymentsController
  respond_to :html, :js
  before_filter :prepare_search
  layout 'user/login'

  def personal
    @user = current_user
    @disability_types = ::Employments::DisabilityType.all
    @disability_certifications = ::Employments::DisabilityCertification.all
    @countries = ::Employments::Country.all
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb "Curriculum"
  end

  def save
    puts " ........... #{item_params.inspect}"
    @user = User.find current_user.id
    @user.assign_attributes item_params
    @success = @user.save
    params = {}
    item_params = {}
    puts "------------params #{params.inspect}\n -----------item_params #{item_params.inspect}"
    unless @success
      flash[:notice] = 'No se pudo actualizar la información'
      @errors = @user.errors.messages.to_json.html_safe
      render :personal
    end
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
      specialties_attributes: [:id, :country_id, :esp_code, :gra_code, :institution_name, :certificate, :start_at, :end_at, :_destroy],
      trainings_attributes: [:id, :institution_name, :name, :description, :place, :duration, :year, :_destroy],
      work_experiences_attributes: [:id, :sector, :country_id, :institution_name, :charge, :description, :start_at, :end_at, :active, :_destroy],
      languages_attributes: [:id, :name, :read, :write, :speak, :_destroy],
      disabilities_attributes: [:id, :disability_type_id, :disability_certification_id, :_destroy]
    )
  end

  protected

  def prepare_search
    @q = Employments::Plaza.ransack(params[:q])
  end

end
