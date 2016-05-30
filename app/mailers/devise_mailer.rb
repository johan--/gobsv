class DeviseMailer < Devise::Mailer

  helper :application
  include Devise::Controllers::UrlHelpers

  default from: 'info@gobiernoabierto.gob.sv'

  def reset_password_instructions(record, token, opts={})
    @token = token
    puts "============== TOKEN#{@token}"
    devise_mail(record, :reset_password_instructions, opts)
  end

end
