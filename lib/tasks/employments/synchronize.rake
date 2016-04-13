require 'net/http'
require 'json'

namespace :employments do

  desc 'Import tables from ws'
  task :import => [:environment] do
    # Reload settings
    Settings.reload!
    begin
      # First get a valid token
      uri = URI('http://www.funcionpublica.gob.sv/STPPplazas/token')
      params = {
        'Username' => Settings.sapt.username,
        'Password' => Settings.sapt.password,
        'Grant_Type' => Settings.sapt.grant_type
      }
      res = Net::HTTP.post_form(uri, params)
      json = JSON.parse(res.body, symbolize_names: true)
      access_token = [json[:token_type], json[:access_token]].join(' ')
      # Get factors
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/VistaFactores', access_token
      jsons.each do |json|
        obj = Employments::Factor.where(factor_id: json[:idFactor], plaza_id: json[:idPlaza]).first_or_initialize
        obj.name = json[:nombreFactor]
        obj.factor_score_id = json[:idFactorPuntaje]
        obj.minimum_score = json[:FactorPuntajeMinimo]
        obj.maximum_score = json[:FactorPuntajeMaximo]
        obj.order = json[:ordenFactor]
        obj.save
      end
      # Get areas
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/Area', access_token
      jsons.each do |json|
        obj = Employments::Area.where(id: json[:idArea]).first_or_initialize
        obj.factor_score_id = json[:idFactorPuntaje]
        obj.name = json[:nombreArea]
        obj.order = json[:ordenArea]
        obj.score = json[:puntajeArea]
        obj.save
      end
      # Get degrees
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/GOES_Grado', access_token
      jsons.each do |json|
        obj = Employments::Degree.where(id: json[:idCorrelativo]).first_or_initialize
        obj.plaza_id = json[:idPlaza]
        obj.gra_code = json[:GRA_CODIGO]
        obj.gra_name = json[:GRA_NOMBRE]
        obj.req_code = json[:REQ_CODIGO]
        obj.req_name = json[:REQ_NOMBRE]
        obj.save
      end
      # Get experiences
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/GOES_Experiencia', access_token
      jsons.each do |json|
        obj = Employments::Experience.where(id: json[:idCorrelativo]).first_or_initialize
        obj.plaza_id = json[:idPlaza]
        obj.exp_code = json[:EXP_CODIGO]
        obj.exp_name = json[:EXP_NOMBRE]
        obj.exp_description = json[:EXP_DESCRIPCION]
        obj.save
      end
      # Get languages
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/GOES_Idioma', access_token
      jsons.each do |json|
        obj = Employments::Language.where(id: json[:idCorrelativo]).first_or_initialize
        obj.plaza_id = json[:idPlaza]
        obj.idi_code = json[:IDI_CODIGO]
        obj.idi_name = json[:IDI_NOMBRE]
        obj.req_code = json[:REQ_CODIGO]
        obj.req_name = json[:REQ_NOMBRE]
        obj.save
      end
      # Get specialties
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/GOES_Especialidad', access_token
      jsons.each do |json|
        obj = Employments::Specialty.where(id: json[:idCorrelativo]).first_or_initialize
        obj.plaza_id = json[:idPlaza]
        obj.esp_code = json[:ESP_CODIGO]
        obj.esp_name = json[:ESP_NOMBRE]
        obj.req_code = json[:REQ_CODIGO]
        obj.req_name = json[:REQ_NOMBRE]
        obj.save
      end
      # Get technical competences
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/GOES_CompTecnica', access_token
      jsons.each do |json|
        obj = Employments::TechnicalCompetence.where(id: json[:idCorrelativo]).first_or_initialize
        obj.plaza_id = json[:idPlaza]
        obj.name = json[:TEC_NOMBRE]
        obj.req_code = json[:REQ_CODIGO]
        obj.req_name = json[:REQ_NOMBRE]
        obj.save
      end
      # Get public competitions
      Employments::PublicCompetition.update_all(active: false)
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/VistaConcursosPublicos', access_token
      jsons.each do |json|
        obj = Employments::PublicCompetition.where(identifier: json[:Identificador]).first_or_initialize
        obj.post_name = json[:nombrePuesto]
        obj.convocation_id = json[:idConvocatoria]
        obj.convocation_name = json[:nombreConvocatoria]
        obj.institution_id = json[:idInstitucion]
        obj.institution_name = json[:nombreInstitucion]
        obj.institution_code = json[:siglasInstitucion]
        obj.autonomous = json[:autonoma]
        obj.plaza_id = json[:idPlaza]
        obj.plaza_state_id = json[:idEstadoPlaza]
        obj.plaza_state = json[:nombreEstadoPlaza]
        obj.vacancies = json[:vacantes]
        obj.salary = json[:salario]
        obj.opening_registration = json[:fechaInicioInscripcion]
        obj.closing_registration = json[:fechaCierreInscripcion]
        obj.inspto_code = json[:COD_INSPTO]
        obj.organization_department = json[:organizacionPuesto]
        obj.mission = json[:misionPuesto]
        obj.function = json[:funcionPuesto]
        obj.result = json[:resultadoPuesto]
        obj.frame = json[:marcoPuesto]
        obj.description = json[:descripcionPuesto]
        obj.email = json[:correoelectronico]
        obj.address = json[:direccion]
        obj.phone = json[:telefono]
        obj.comment = json[:comentario]
        obj.created_date = json[:fechaCreacion]
        obj.updated_date = json[:fechaModificacion]
        obj.created_user = json[:usuarioCreacion]
        obj.updated_user = json[:usuarioModificacion]
        obj.contract_type = json[:nombreContratacion]
        obj.location = json[:Ubicacion]
        obj.participants_number = json[:numeroParticipantes]
        obj.closing_comment = json[:cierreComentario]
        obj.active = true
        obj.save
      end
      # Get contracts
      jsons = get_json_data 'http://www.funcionpublica.gob.sv/STPPplazas/api/Contratos', access_token
      jsons.each do |json|
        obj = Employments::Contract.where(id: json[:idContrato]).first_or_initialize
        obj.plaza_id = json[:idPlaza]
        obj.name = json[:nombre]
        obj.last_name = json[:apellido]
        obj.save
      end
      UserMailer.report_employments_import(Time.current.strftime('%d/%m/%Y %H:%M:%S'), false).deliver
    rescue Exception => e
      UserMailer.report_employments_import(e, true).deliver
    end
  end

  def get_json_data url, token
    uri = URI(url)
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = token
    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    jsons = JSON.parse(res.body, symbolize_names: true)
  end

end
