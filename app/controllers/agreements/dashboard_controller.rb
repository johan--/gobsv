class Agreements::DashboardController < AgreementsController

  def index
    @signed = ::Agreements::UserPeaceSignature.count rescue 0
    @user_signature = ::Agreements::UserPeaceSignature.new
  end

  def create
    @user_signature = ::Agreements::UserPeaceSignature.new item_params
    @success = @user_signature.save 
    if @success
      @counter = sprintf('%05d', ::Agreements::UserPeaceSignature.count) 
    else
      @error = "Ha ocurrido un error al guardar"
      @errors = @user_signature.errors.full_messages
    end
  end
  
  def item_params
    params.require(:agreements_user_peace_signature).permit(
      :name,
      :email,
      :place
    )
  end

end