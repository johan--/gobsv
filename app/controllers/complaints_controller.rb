class ComplaintsController < ApplicationController
  before_action :authenticate_admin!
  before_action :prepare_search

  #include Pundit
  #after_action :verify_authorized, except: :index
  #after_action :verify_policy_scoped, only: :index

  #rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  def menu_active
    @menu_active ||= menu_active_element
  end
  helper_method :menu_active

  def menu_active_element
    if params[:state].present?
      # Iniciamos evaluando si tenemos un parámetro state
      return params[:state].to_s
    elsif controller_name == 'users'
      return 'users'
    elsif controller_name == 'statistics'
      return 'statistics'
    elsif controller_name == 'documents'
      return 'documents'
    elsif defined? expedient
      # Evaluamos si tenemos un elemento
      return expedient.status
    end
  end

  def prepare_search
    if current_admin.oficial?
      @search = ::Complaints::Expedient.newer.status(params[:state]).ransack(params[:search], search_key: :search)
    else
      @search = ::Complaints::Expedient.newer.joins(:managements).where("complaints_expedient_managements.assigned_ids @> '{?}'", current_admin.id).status(params[:state]).ransack(params[:search], search_key: :search)
    end
  end

  private

   def permission_denied
     head 403
   end
end
