class Employments::PlazaFactor < ActiveRecord::Base
  default_scope { order(order: :asc) }
  scope :active, -> { where(active: true) }
  has_many :areas, foreign_key: :factor_score_id, primary_key: :factor_score_id
end
