require 'net/http'
class GovermentServices::InstitutionServicesController < GovermentServicesController
  skip_before_action :verify_authenticity_token
  before_action :prepare_breadcrumb

  def index
    institutions_source = URI.parse "http://api.gobiernoabierto.gob.sv/institution_services/institutions"
    resp = Net::HTTP.get(institutions_source)
    data = resp
    @institutions = Hash[JSON.parse(data).map{|key, value| [key, value]}] 

    #service_category_source = URI.parse "http://api.gobiernoabierto.gob.sv/institution_services/#{params[:id]}/institution_service_categories"
    id = params[:institution_id].to_i
    service_category_source = URI.parse "http://api.gobiernoabierto.gob.sv/institution_services/#{id}/institution_service_categories"
    service_resp = Net::HTTP.get(service_category_source)
    service_data = service_resp
    @service_categories = JSON.parse(service_data) rescue nil

  end

  def show
    service_source = URI.parse "http://api.gobiernoabierto.gob.sv/institution_services/#{params[:id]}/institution_service"
    service_resp = Net::HTTP.get(service_source)
    service_data = service_resp
    @service = JSON.parse(service_data) rescue nil

    steps_source = URI.parse "http://api.gobiernoabierto.gob.sv/institution_services/#{params[:id]}/institution_service_steps"
    steps_resp = Net::HTTP.get(steps_source)
    steps_data = steps_resp
    @service_steps = JSON.parse(steps_data) rescue nil

  end

  private

    def prepare_breadcrumb
      add_breadcrumb 'Servicios Públicos', goverment_services_root_url
      add_breadcrumb 'Instituciones', goverment_services_institution_services_url
      add_breadcrumb "Servicio"
    end

end