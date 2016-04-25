class Employments::Plaza < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  scope :available, -> { where(plaza_state_id: 2).where("? BETWEEN employments_plazas.opening_registration::date AND employments_plazas.closing_registration::date", Date.current) }
  scope :evaluation, -> { where(plaza_state_id: [3,5,6]) }
  scope :closed, -> { where(plaza_state_id: 4) }

  has_many :plaza_skills, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_experiences, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_degrees, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_factors, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_specialties, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_languages, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_contracts, foreign_key: :plaza_id, primary_key: :plaza_id
end
