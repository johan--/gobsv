module Ofcia
  class PayrollEconomicActivity < ActiveRecord::Base
    has_many :payroll_patrons

    has_many :payrolls,
             through: :payroll_patrons
  end
end
