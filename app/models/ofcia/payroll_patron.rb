class Ofcia::PayrollPatron < ActiveRecord::Base
  # belongs_to :payroll_sector,
  #            class_name: 'Ofcia::PayrollSector',
  #            foreign_key: :sector_id

  belongs_to :payroll_economic_activity
            #  class_name: 'Ofcia::PayrollEconomicActivity',
            #  foreign_key: :economic_activity_id

  has_many :payrolls
  #          class_name: 'Ofcia::Payroll',
  #          foreign_key: :no_patronal,
  #          primary_key: :employer_id
end
