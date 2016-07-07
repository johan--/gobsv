namespace :ofcia do
  namespace :payroll_maintenances do
    desc 'Carga las tablas de mantenimientos para planillas (payrolls)'
    task load: [:environment] do
      client = Savon.client(
        wsdl: 'https://app-qas.isss.gob.sv:8890/CapresEndPoint/TransactionExecutorPort?WSDL',
        ssl_verify_mode: :none
      )

      ###
      # Ofcia::PayrollType

      response = client.call(:obtener_tipo_planilla)
      jsons = response.body[:obtener_tipo_planilla_response][:return].to_s
      items = JSON.parse(jsons)
      settings = {
        id: 'idTipoPlanilla',
        name: 'nombreTipoPlanilla'
      }
      create_records(Ofcia::PayrollType, settings, items)

      ###
      # Ofcia::PayrollStatus

      response = client.call(:obtener_estado_planilla)
      jsons = response.body[:obtener_estado_planilla_response][:return].to_s
      items = JSON.parse(jsons)
      settings = {
        id: 'codEstadoPlanilla',
        name: 'nombreEstadoPlanilla',
        description: 'descEstadoPlanilla'
      }
      create_records(Ofcia::PayrollStatus, settings, items)

      ###
      # Ofcia::PayrollSector

      response = client.call(:obtener_sectores)
      jsons = response.body[:obtener_sectores_response][:return].to_s
      items = JSON.parse(jsons)
      settings = {
        id: 'codSector',
        name: 'nombreSector'
      }
      create_records(Ofcia::PayrollSector, settings, items)

      ###
      # Ofcia::PayrollObservationCode

      response = client.call(:obtener_codigo_observacion)
      jsons = response.body[:obtener_codigo_observacion_response][:return].to_s
      items = JSON.parse(jsons)
      settings = {
        id: 'idCodigoObservacion',
        name: 'nombreCodigoObservacion',
        description: 'descCodigoObservacion'
      }
      create_records(Ofcia::PayrollObservationCode, settings, items)

      ###
      # Ofcia::PayrollEconomicActivity

      response = client.call(:obtener_actividad_economica)
      jsons = response.body[:obtener_actividad_economica_response][:return].to_s
      items = JSON.parse(jsons)
      settings = {
        id: 'codActividadEconomica',
        name: 'nombreActividadEconomica',
        economic_activity_group: 'codGrupoActividadEconomica'
      }
      create_records(Ofcia::PayrollEconomicActivity, settings, items)

      ###
      # Ofcia::PayrollEconomicActivityGroup

      response = client.call(:obtener_grupo_actividad_economica)
      jsons = response.body[:obtener_grupo_actividad_economica_response][:return].to_s
      items = JSON.parse(jsons)
      settings = {
        id: 'codGrupoActividadEconomica',
        name: 'nombreGrupoActividadEconomica'
      }
      create_records(Ofcia::PayrollEconomicActivityGroup, settings, items)
    end

    def create_records(model, settings, items)
      items.each do |item|
        o = model.where(id: item[settings[:id]]).first_or_initialize
        settings.keys.each do |local_attr|
          o.send("#{local_attr}=", item[settings[local_attr]])
        end
        o.save
      end
    end
  end
end
