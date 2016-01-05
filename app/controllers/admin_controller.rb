class AdminController < ApplicationController
  # Includes Authorization mechanism

  # include Pundit
  # before_action :authenticate_admin!

  # def pundit_user
  #   current_admin
  # end

  # def user_for_paper_trail
  #   current_admin ? current_admin.id : nil
  # end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  ### protect_from_forgery with: :exception

  # Globally rescue Authorization Errors in controller.
  # Returning 403 Forbidden if permission is denied
  ### rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  # Enforces access right checks for individuals resources
  ### after_filter :verify_authorized, except: :index

  # Enforces access right checks for collections
  ### after_filter :verify_policy_scoped, only: :index

  ### private

  ### def permission_denied
  ###   head 403
  ### end
end
