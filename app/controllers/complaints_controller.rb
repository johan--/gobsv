class ComplaintsController < ApplicationController
  before_action :authenticate_admin!

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
end
