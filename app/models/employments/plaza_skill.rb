class Employments::PlazaSkill < ActiveRecord::Base
  scope :indispensable, -> {where(req_code: 2)}
end
