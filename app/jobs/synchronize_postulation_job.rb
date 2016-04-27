class SynchronizePostulationJob < ActiveJob::Base
  queue_as :default

  def perform(postulation)
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
      #response = RestClient.post 'http://192.168.1.5:3000/resumes/save',
      response = RestClient.post 'http://www.funcionpublica.gob.sv/STPPplazas/api/ConcursoPostulante',
      {
        idUsuario: postulation.user.try(:stpp_id),
        idPlaza: postulation.plaza.try(:plaza_id)
      },
      {:Authorization => access_token}
      postulation.update_column(:response_code, response.code)
      # TODO Cambiar luego
      unless response.code == 500
        UserMailer.confirm_postulation(postulation)
      end
    rescue Exception => e
      postulation.update_column(:response_code, 500)
    end

  end
end
