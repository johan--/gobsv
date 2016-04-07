class Complaints::ExpedientManagementComment < ActiveRecord::Base
  belongs_to :admin
  has_and_belongs_to_many :assets
  validates :comment, presence: true

end
