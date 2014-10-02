class DeviseMailer < Devise::Mailer

  helper :application
  include Devise::Controllers::UrlHelpers

  default from: 'info@gobiernoabierto.gob.sv'
end
