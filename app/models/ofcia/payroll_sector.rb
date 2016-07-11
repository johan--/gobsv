class Ofcia::PayrollSector < ActiveRecord::Base
  has_many :payroll_patrons,
           class_name: 'Ofcia::PayrollPatron',
           foreign_key: :sector_id

  has_many :payrolls,
           class_name: 'Ofcia::Payroll',
           through: :payroll_patrons

  scope :has_payrolls, lambda {
    eager_load(:payrolls)
      .where
      .not(ofcia_payrolls: { id: nil })
  }
end
