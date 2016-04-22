class Employments::UserDisability < ActiveRecord::Base
  belongs_to :user
  belongs_to :disability_type, class_name:  '::Employments::DisabilityType'
  belongs_to :disability_certification, class_name:  '::Employments::DisabilityCertification'

end
