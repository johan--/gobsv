class Employments::UserTraining < ActiveRecord::Base
  validates :name, length: { maximum: 200 }
  validates :description, length: { maximum: 500 }
  validates :duration, length: { maximum: 50 }
  validates :place, :institution_name, length: { maximum: 100 }
end
