class ServController < ActionController::Base

  before_action :authenticate_admin!
  include DeviseTokenAuth::Concerns::SetUserByToken
end
