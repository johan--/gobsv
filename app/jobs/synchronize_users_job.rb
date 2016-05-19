class SynchronizeUsersJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    if user
      languages = user.languages.collect{ |l|
        {
          'IDI_CODIGO' => l.code,
          'IDI_NOMBRE' => l.name_s,
          'IDI_Lee' => l.read.to_i,
          'IDI_Escribe' => l.write.to_i,
          'IDI_Habla' => l.speak.to_i
        }
      }
      references = user.references.collect{ |r|
        {
          'nombreReferencia' => r.name,
          'cargoReferencia' => r.charge,
          'direccionReferencia' => r.address,
          'telefonoReferencia' => r.phone,
          'tipoReferencia' => r.code,
        }
      }
      trainings = user.trainings.collect{ |t|
        {
          'tituloCapacitacion' => t.name,
          'conocimientosCapacitacion' => t.description,
          'duracionCapacitacion' => t.duration,
          'lugarCapacitacion' => t.place,
          'institucionCapacitacion' => t.institution_name,
          'anio' => t.year
        }
      }
      experiences = user.work_experiences.collect { |w|
        {
          'nombreInstitucion' => w.institution_name,
          'idPais' => w.country_id,
          'nombrePuesto' => w.charge,
          'idSector' => w.sector,
          'descripcionPuesto' => w.description,
          'inicioMes' => w.start_at.month,
          'inicioAnio' => w.start_at.year,
          'finMes' => w.end_at.month,
          'finAnio' => w.end_at.year,
          'activo' => w.active
        }
      }
      disabilities = user.disabilities.collect { |d|
        {
          'idTipoDiscapacidad' => d.disability_type.try(:code),
          'idCertificado' => d.disability_certification.code
        }
      }
      specialties = user.specialties.collect { |s|
        {
          'ESP_CODIGO' => s.esp_code,
          'ESP_NOMBRE' => s.esp_name,
          'GRA_CODIGO' => s.gra_code,
          'insNombre' => s.institution_name,
          'idPais' => s.country_id,
          'inicioMes' => s.start_at.month,
          'inicioAnio' => s.start_at.year,
          'finMes' => s.end_at.month,
          'finAnio' => s.end_at.year,
          'certificado' => "#{Time.current.to_i}_#{s.certificate_file_name}",
          'certificado_url' => "http://www.empleospublicos.gob.sv#{s.certificate.url(:original, timestamp: false)}"
        }
      }
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
      begin
        #response = RestClient.post 'http://192.168.1.43/ServicioDotacion/api/usuario',
        #response = RestClient.post 'http://192.168.1.5:3000/resumes/save',
=begin
        puts "\n login: #{user.document_number.gsub(/[^0-9]/i, '')}"
        puts "\n clave: #{(0...20).map { (65 + rand(26)).chr }.join}"
        puts "\n name: #{user.name}"
        puts "\n lastname: #{user.last_name}"
        puts "\n email: #{user.email}"
        puts "\n idTratamiento: #{user.treatment}"
        puts "\n telefonoContacto1: #{user.phone}"
        puts "\n telefonoContacto2: #{user.alt_phone}"
        puts "\n direccion: #{user.address}"
        puts "\n sexo: #{user.gender_s}"
        puts "\n nacionalidad: #{user.country_id}"
        puts "\n fechanacimiento: #{user.birthday}"
        puts "\n NIT: #{user.tax_id}"
        puts "\n documento: #{user.document_code}"
        puts "\n DUI: #{user.document_number_clean(true)}"
        puts "\n carneExtranjero: #{user.document_number_clean(false)}"
        puts "\n 'USU_Idioma[]' => #{languages.inspect}"
        puts "\n 'USU_Referencias[]' => #{references.inspect}"
        puts "\n 'USU_Capacitaciones[]' => #{trainings.inspect}"
        puts "\n 'USU_Experiencia[]' => #{experiences.inspect}"
        puts "\n 'USU_Discapacidad[]' => #{disabilities.inspect}"
        puts "\n 'USU_Especialidad[]' => #{specialties.inspect}\n"
=end
        response = RestClient.post 'http://www.funcionpublica.gob.sv/STPPplazas/api/Usuario',
          {
            login: user.document_number.gsub(/[^0-9]/i, ''),
            clave: (0...20).map { (65 + rand(26)).chr }.join,
            name: user.name,
            lastname: user.last_name,
            email: user.email,
            idTratamiento: user.treatment,
            telefonoContacto1: user.phone,
            telefonoContacto2: user.alt_phone,
            direccion: user.address,
            sexo: user.gender_s,
            nacionalidad: user.country_id,
            fechanacimiento: user.birthday,
            NIT: user.tax_id,
            documento: user.document_code,
            DUI: user.document_number_clean(true),
            carneExtranjero: user.document_number_clean(false),
            'USU_Idioma[]' => languages,
            'USU_Referencias[]' => references,
            'USU_Capacitaciones[]' => trainings,
            'USU_Experiencia[]' => experiences,
            'USU_Discapacidad[]' => disabilities,
            'USU_Especialidad[]' => specialties
          },
          {:Authorization => access_token}
        unless response.code == 500
          id = Hash.from_xml(response)['int'].to_i rescue 0
          if id > 0
            user.update_column(:stpp_id, id)
          end
        end
        user.update_column(:response_code, response.code)
      rescue Exception => e
        user.update_column(:response_code, 500)
      end
    end
  end
end
