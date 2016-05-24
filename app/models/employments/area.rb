class Employments::Area < ActiveRecord::Base
  scope :active, -> { where(active: true) }
end
