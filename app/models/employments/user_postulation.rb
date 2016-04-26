class Employments::UserPostulation < ActiveRecord::Base
  belongs_to :plaza
  belongs_to :user

  validates_acceptance_of :terms
  validates :plaza_id, :user_id, presence: true
  validates :plaza_id, uniqueness: { scope: :user_id }

  before_create :set_code
  after_create :send_postulation

  def set_code
    self.code = "#{plaza.try(:identifier)}.#{user.try(:stpp_id)}"
  end

  def send_postulation
    SynchronizePostulationJob.perform_later(self)
  end

end
