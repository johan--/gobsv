class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    exclude = [
      :omniauth_callbacks,
      :passwords,
      :registrations,
      :sessions
    ]
    return if exclude.include?(controller_name.to_sym)
    session[:previous_url] = request.original_url
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || user_root_url
  end
end