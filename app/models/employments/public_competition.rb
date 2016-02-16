class Employments::PublicCompetition < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  scope :available, -> { where(plaza_state_id: 2).where("? BETWEEN employments_public_competitions.opening_registration::date AND employments_public_competitions.closing_registration::date", Date.current) }
  scope :evaluation, -> { where(plaza_state_id: 3) }
  scope :closed, -> { where(plaza_state_id: 4) }

  has_many :technical_competences, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :experiences, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :degrees, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :factors, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :specialties, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :languages, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :contracts, foreign_key: :plaza_id, primary_key: :plaza_id
end
