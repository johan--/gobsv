class Ta::Category < ActiveRecord::Base
  validates :name, presence: true  
end
