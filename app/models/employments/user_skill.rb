class Employments::UserSkill < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { maximum: 300 }

end
