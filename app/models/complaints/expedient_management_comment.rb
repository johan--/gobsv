class Complaints::ExpedientManagementComment < ActiveRecord::Base
  belongs_to :admin

  validates :comment, presence: true

end
