class SynchronizePostulationJob < ActiveJob::Base
  queue_as :default

  def perform(user, plaza)
    response = RestClient.post 'http://192.168.1.43/ServicioDotacion/api/ConcursoPostulante',
    {
      idUsuario: user.stpp_id,
      idPlaza: plaza.plaza_id
    }

  end
end
