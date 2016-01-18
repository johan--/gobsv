class Employments::PublicCompetition < ActiveRecord::Base
  scope :valid, -> { where(plaza_state_id: 2) }
  scope :active, -> { where(active: true).where("? BETWEEN employments_public_competitions.opening_registration AND employments_public_competitions.closing_registration", Date.current) }

  has_many :technical_competences, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :experiences, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :degrees, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :factors, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :specialties, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :languages, foreign_key: :plaza_id, primary_key: :plaza_id
end
