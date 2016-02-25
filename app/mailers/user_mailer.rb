class UserMailer < ActionMailer::Base
  default from: "info@gobiernoabierto.gob.sv"

  def postures_picture
    attachments['postures.png'] = File.read("#{Rails.root.to_s}/tmp/crop.png")
    mail(subject: "Captura posturas reforma de pensiones", to: 'henry@gobiernoabierto.gob.sv')
  end
end
