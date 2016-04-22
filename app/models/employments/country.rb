class Employments::Country < ActiveRecord::Base

  def code
    id
  end
end
