class Employments::PagesController < EmploymentsController
  before_action :define_params
  before_action :prepare_breadcrumb

  def terms
    add_breadcrumb 'Términos y condiciones'
  end

  def verify_email
    add_breadcrumb 'Verificar correo electrónico'
  end


private
  def define_params
    params[:q] ||= {}
  end
  def prepare_breadcrumb
    add_breadcrumb 'Inicio', employments_root_url
  end
end
