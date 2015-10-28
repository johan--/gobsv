class Complaints::ExpedientManagementEvent < ActiveRecord::Base
  belongs_to :expedient_management, class_name: '::Complaints::ExpedientManagement'

  attr_accessor :weight
  attr_accessor :closed_as

  validates :status, presence: true
  validates :weight, :closed_as, presence: true, if: Proc.new{ |a| a.status == 'closed' }
  #validates :justification, presence: true
end
