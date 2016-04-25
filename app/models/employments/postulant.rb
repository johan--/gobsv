class Employments::Postulant < ActiveRecord::Base

=begin
idEstadoConcursoPostulante    nombreEstado
1             Ingresado
2             Abandonó
3             RECHAZADO: Presentación por documento(s) no válido(s)
4             RECHAZADO: Faltaron aptitudes para el puesto
5             APROBADO (1a. Etapa)
=end

end
