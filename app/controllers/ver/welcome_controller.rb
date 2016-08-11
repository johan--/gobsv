class Ver::WelcomeController < VerController

  def index
    @inscription = Ver::Inscription.new
  end


end
