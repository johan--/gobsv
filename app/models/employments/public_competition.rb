class Employments::PublicCompetition < ActiveRecord::Base
  scope :valid, -> { where.not(plaza_state_id: nil) }
end
