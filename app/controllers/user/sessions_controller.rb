class User::SessionsController < Devise::SessionsController
  before_filter :prepare_search, :draw_breadcrumb
  layout 'user/login'

  def draw_breadcrumb
    add_breadcrumb 'Inicio', employments_jobs_path
    add_breadcrumb "Usuario", user_root_url
  end

  def prepare_search
    @q = Employments::PublicCompetition.ransack(params[:q])
  end
end
