class Employments::PlazaContract < ActiveRecord::Base

  def full_name
    [name, last_name].join(', ')
  end

end
