# Ofcia::Payroll
class Ofcia::Payroll < ActiveRecord::Base
  belongs_to :payroll_observation_code,
             class_name: 'Ofcia::PayrollObservationCode',
             foreign_key: :id_codigo_observacion

  belongs_to :payroll_status,
             class_name: 'Ofcia::PayrollStatus',
             foreign_key: :id_estado_planilla

  belongs_to :payroll_type,
             class_name: 'Ofcia::PayrollType',
             foreign_key: :id_tipo_planilla

  belongs_to :payroll_patron,
             class_name: 'Ofcia::PayrollPatron',
             foreign_key: :no_patronal,
             primary_key: :employer_id
end
