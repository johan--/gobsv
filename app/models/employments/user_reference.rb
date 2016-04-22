class Employments::UserReference < ActiveRecord::Base
  belongs_to :user

  ReferenceType = {
    1 => "Laboral",
    2 => "Personal"
  }


  def code
    kind == 1 ? 1 : 0;
  end

end
