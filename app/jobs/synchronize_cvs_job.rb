class SynchronizeCvsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
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
    response = RestClient.post 'http://www.funcionpublica.gob.sv/STPPplazas/api/prueba',
      {
      url: 'http://empleospublicos.gob.sv/system/employments/user_specialties/certificates/000/000/001/original/guia-4.pdf',
      nombre: "1461336042_guia-4.pdf"
      }#,
      #{:Authorization => access_token}
    puts "\n=================="
    puts response
    puts "\n============================"
  end
end
