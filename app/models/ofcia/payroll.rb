# Ofcia::Payroll
class Ofcia::Payroll < ActiveRecord::Base
  # belongs_to :payroll_observation_code,
  #            class_name: 'Ofcia::PayrollObservationCode',
  #            foreign_key: :id_codigo_observacion
  #
  # belongs_to :payroll_status,
  #            class_name: 'Ofcia::PayrollStatus',
  #            foreign_key: :id_estado_planilla

  # belongs_to :payroll_type,
  #            class_name: 'Ofcia::PayrollType',
  #            foreign_key: :id_tipo_planilla

  belongs_to :payroll_patron
            #  class_name: 'Ofcia::PayrollPatron',
            #  foreign_key: :no_patronal,
            #  primary_key: :employer_id

  # scope :economic_activity, lambda { |economic_activity_id|
  #   joins(:payroll_patron)
  #     .where(
  #       ofcia_payroll_patrons: {
  #         economic_activity_id: economic_activity_id
  #       }
  #     )
  # }

  # scope :sector, lambda { |sector_id|
  #   joins(:payroll_patron)
  #     .where(
  #       ofcia_payroll_patrons: {
  #         sector_id: sector_id
  #       }
  #     )
  # }

  # scope :year, lambda { |year|
  #   where ['SUBSTRING(periodo, 1, 4)::INTEGER = ?', year]
  # }
  #
  # scope :month, lambda { |month|
  #   where ['SUBSTRING(periodo, 5, 2)::INTEGER = ?', month]
  # }

  # def self.first_year
  #   minimum 'SUBSTRING(periodo, 1, 4)::INTEGER'
  # end
  
  # def self.last_year
  #   maximum 'SUBSTRING(periodo, 1, 4)::INTEGER'
  # end
end
