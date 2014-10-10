class Subdomain
  def self.matches?(request)

    case request.host
    when 'consulta.gob.sv', 'www.consulta.gob.sv', 'consulta.localhost.com'
      true
    else
      false
    end
  end

end
