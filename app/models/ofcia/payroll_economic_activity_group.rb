class Ofcia::PayrollEconomicActivityGroup < ActiveRecord::Base
  has_many :payroll_economic_activities,
           class_name: 'Ofcia::PayrollEconomicActivity',
           foreign_key: :economic_activity_group
end
