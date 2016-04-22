class SynchronizePostulationJob < ActiveJob::Base
  queue_as :default

  def perform(user, plaza)
    # First get a valid token
    uri = URI('http://www.funcionpublica.gob.sv/STPPplazas/token')
    params = {
      'Username' => Settings.sapt.username,
      'Password' => Settings.sapt.password,
      'Grant_Type' => Settings.sapt.grant_type
    }
    response = RestClient.post 'http://www.funcionpublica.gob.sv/STPPplazas/api/ConcursoPostulante',
    {
      idUsuario: user.stpp_id,
      idPlaza: plaza.plaza_id
    },
    {:Authorization => access_token}

  end
end
