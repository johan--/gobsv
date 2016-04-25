class Employments::SessionsController < Devise::SessionsController
  before_filter :prepare_search, :draw_breadcrumb
  layout 'user/login'

  def draw_breadcrumb
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb 'Usuarios'
  end

  def prepare_search
    @q = Employments::Plaza.ransack(params[:q])
  end
end
