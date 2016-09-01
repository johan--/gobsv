class GovermentServices::InstitutionServicesController < GovermentServicesController
  before_action :prepare_breadcrumb

  def index
    redirect_to goverment_services_institution_service_url(1) and return
  end

  def show
  end

  private

    def prepare_breadcrumb
      add_breadcrumb 'Servicios Públicos', goverment_services_root_url
      add_breadcrumb 'Instituciones', goverment_services_institution_services_url
      add_breadcrumb "Servicio"
    end

end