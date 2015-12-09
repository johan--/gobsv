class Employments::PublicCompetition < ActiveRecord::Base
  scope :valid, -> { where.not(plaza_state_id: nil) }

  has_many :technical_competences, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :experiences, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :degrees, foreign_key: :plaza_id, primary_key: :plaza_id
end
