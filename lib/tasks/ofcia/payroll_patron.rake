namespace :ofcia do
  namespace :payroll_patrons do
    desc 'Carga la tabla ofcia_patrons'
    task load: [:environment] do
      client = Savon.client(
        wsdl: 'https://app-qas.isss.gob.sv:8890/CapresEndPoint/TransactionExecutorPort?WSDL',
        ssl_verify_mode: :none
      )

      response = client.call(:conteo_patrono)
      total = response.body[:conteo_patrono_response][:return].to_i
      per_page = 1000
      pages = (total / per_page).ceil

      (1..pages).each do |page|
        from = page * per_page - per_page + 1
        to = page * per_page

        response = client.call(
          :obtener_patrono_por_rango,
          message: { arg0: from, arg1: to }
        )

        json = response.body[:obtener_patrono_por_rango_response][:return].to_s
        items = JSON.parse(json)

        items.each do |item|
          patron = ::Ofcia::PayrollPatron
                   .where(employer_id: item['noPatronal'])
                   .first_or_initialize

          patron.employer_id = item['noPatronal']
          patron.name = item['nombrePatrono']
          patron.nit = item['nit']
          patron.sector_id = item['codigoSector']
          patron.economic_activity_id = item['codigoActEconomica']
          patron.save
        end
      end
    end
  end
end
