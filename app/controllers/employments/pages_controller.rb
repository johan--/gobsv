class Employments::PagesController < EmploymentsController
  before_action :define_params
  before_action :prepare_breadcrumb



private
  def define_params
    params[:q] ||= {}
  end
  def prepare_breadcrumb
    add_breadcrumb 'Inicio', employments_root_url
    add_breadcrumb 'Términos y condiciones'
  end
end
