class Ofcia::PayrollEconomicActivity < ActiveRecord::Base
  has_many :payroll_patrons,
           class_name: 'Ofcia::PayrollPatron',
           foreign_key: :economic_activity_id

  has_many :payrolls,
           class_name: 'Ofcia::Payroll',
           through: :payroll_patrons

  scope :has_payrolls, lambda {
    eager_load(:payrolls)
      .where
      .not(ofcia_payrolls: { id: nil })
  }

  scope :sector, lambda { |sector_id|
    eager_load(:payrolls)
      .where
      .not(ofcia_payrolls: { id: nil })
      .where(ofcia_payroll_patrons: { sector_id: sector_id })
  }
end
