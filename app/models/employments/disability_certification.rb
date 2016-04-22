class Employments::DisabilityCertification < ActiveRecord::Base

  def code
    id > 7 ? 0 : id
  end
  
end
