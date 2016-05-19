class Employments::UserReference < ActiveRecord::Base
  belongs_to :user
  validates :phone, length: { maximum: 9 }
  validates :name, length: { maximum: 150 }
  validates :charge, length: { maximum: 100 }
  validates :address, length: { maximum: 200 }

  ReferenceType = {
    1 => "Laboral",
    2 => "Personal"
  }


  def code
    kind == 1 ? 1 : 0;
  end

end
