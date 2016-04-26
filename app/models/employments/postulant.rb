class Employments::Postulant < ActiveRecord::Base

=begin
idEstadoConcursoPostulante    nombreEstado
1             Ingresado
2             Abandonó
3             RECHAZADO: Presentación por documento(s) no válido(s)
4             RECHAZADO: Faltaron aptitudes para el puesto
5             APROBADO (1a. Etapa)
=end

  STATE = [
    'N/D',
    'Ingresado',
    'Abandonó',
    'RECHAZADO: Presentación por documento(s) no válido(s)',
    'RECHAZADO: Faltaron aptitudes para el puesto',
    'APROBADO (1a. Etapa)'
  ]

  def state
    STATE[postulant_state_competition]
  end

end
