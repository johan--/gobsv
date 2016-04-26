class UserMailer < ActionMailer::Base
  default from: "info@gobiernoabierto.gob.sv"

  def postures_picture
    attachments['postures.png'] = File.read("#{Rails.root.to_s}/tmp/crop.png")
    mail(subject: "Captura posturas reforma de pensiones", to: 'henry@gobiernoabierto.gob.sv')
  end

  def report_employments_import(e, error)
    @error = error
    @exception = e
    mail(
      subject: @error ? "Hubo un error en la sincronización de empleos" : "Sincronización de empleos completada correctamente",
      to: 'henry@gobiernoabierto.gob.sv',
      cc: @error ? 'mmchavez@presidencia.gob.sv' : ''
      )
  end

  def confirm_postulation(postulation)
    @postulation = postulation
    mail(
      subject: "Postulación #{@postulation.plaza.post_name} / empleospublicos.gob.sv",
      to: "#{@postulation.user.email}"
      )
  end
end
