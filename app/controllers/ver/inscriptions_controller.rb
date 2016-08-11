class Ver::InscriptionsController < VerController

  def create
    @inscription = ::Ver::Inscription.new(item_params)
    if @inscription.save
      redirect_to thanks_ver_inscription_url(@inscription) and return
    else
      render template: 'ver/welcome/index'
    end
  end

  def inscription
    @inscription ||= params[:id] ? Ver::Inscription.where(id: params[:id]).first : Ver::Inscription.new
  end
  helper_method :inscription

  def item_params
    params.require(:ver_inscription).permit(
      :firstname,
      :lastname,
      :email,
      :location,
      :age
    )
  end

end
