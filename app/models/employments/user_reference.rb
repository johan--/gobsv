class Employments::UserReference < ActiveRecord::Base
  belongs_to :user

  ReferenceType = {
    1 => "Laboral",
    2 => "Personal"
  }
  
end
