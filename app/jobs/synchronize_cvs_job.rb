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
    response = RestClient.post 'http://www.funcionpublica.gob.sv/STPPplazas/api/prueba',
    {
      url: 'http://empleospublicos.gob.sv/system/employments/user_specialties/certificates/000/000/001/original/guia-4.pdf',
      nombre: "#{Time.current.to_i}_guia4.pdf"
    },
    {:Authorization => access_token}
  end
end
