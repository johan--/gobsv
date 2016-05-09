class Paa::Holder < ActiveRecord::Base
  
  has_many :savings, class_name: '::Paa::Saving'
  accepts_nested_attributes_for :savings

end
