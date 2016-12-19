class Agreements::DashboardController < AgreementsController

  def index
    @signed = ::Agreements::UserPeaceSignature.count rescue 0
    @user_signature = ::Agreements::UserPeaceSignature.new
  end

  def create
    @user_signature = ::Agreements::UserPeaceSignature.new item_params
    @user_signature.country = Country.find(params[:agreements_user_peace_signature][:country]).name rescue nil
    @user_signature.state = State.find(params[:agreements_user_peace_signature][:state]).name rescue nil
    @success = @user_signature.save
    if verify_recaptcha(model: @user_signature) && @success
      @counter = sprintf('%05d', ::Agreements::UserPeaceSignature.count)
    else
      @error = "Ha ocurrido un error al guardar"
      @errors = @user_signature.errors.messages.to_json.html_safe
    end
  end

  def get_states
    @country = Country.find params[:id]
    @states = @country.states
    render json: @states.map{|s| [s.id, s.name]}

  end

  def item_params
    params.require(:agreements_user_peace_signature).permit(
      :name,
      :email,
      :country,
      :state,
      :phone
    )
  end

end
