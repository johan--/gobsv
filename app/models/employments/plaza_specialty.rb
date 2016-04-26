class Employments::PlazaSpecialty < ActiveRecord::Base
  scope :indispensable, -> {where(req_code: 2)}
end
