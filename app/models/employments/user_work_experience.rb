class Employments::UserWorkExperience < ActiveRecord::Base
  belongs_to :user

  Sectors = {
    1 => "Privado",
    2 => "Público",
    3 => "Social"
  }

end
