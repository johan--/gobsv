class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!

  def all
    user = User.from_omniauth(env['omniauth.auth'], current_user)

    if user.persisted?
      flash[:notice] = :already_logged_in
      sign_in_and_redirect(user)
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
    ##
    # TODO logic on failure

    super
  end


  alias_method :facebook,      :all
  alias_method :twitter,       :all
  alias_method :linkedin,      :all
  alias_method :github,        :all
  alias_method :passthru,      :all
  alias_method :google_oauth2, :all
end
