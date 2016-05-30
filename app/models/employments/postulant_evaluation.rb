class Employments::PostulantEvaluation < ActiveRecord::Base
  scope :academic, -> { where(factor_id: 1) }
  scope :technique, -> { where(factor_id: 5) }
  scope :behavior, -> { where(factor_id: 6) }
  scope :interview, -> { where(factor_id: 7) }

end
