class Employments::UserWorkExperience < ActiveRecord::Base
  belongs_to :user

  validates :institution_name, :charge, length: { maximum: 200 }
  validates :description, length: { maximum: 500 }

  Sectors = {
    1 => "Privado",
    2 => "Público",
    3 => "Social"
  }

end
