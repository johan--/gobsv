class Employments::Plaza < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  scope :available, -> { where(plaza_state_id: 2).where("? BETWEEN employments_plazas.opening_registration::date AND employments_plazas.closing_registration::date", Date.current) }
  scope :evaluation, -> { where(plaza_state_id: [3,5,6]) }
  scope :closed, -> { where(plaza_state_id: 4) }

  has_many :plaza_skills, -> { where active: true }, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_experiences, -> { where active: true }, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_degrees, -> { where active: true }, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_factors, -> { where active: true }, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_specialties, -> { where active: true }, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_languages, -> { where active: true }, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :plaza_contracts, -> { where active: true }, foreign_key: :plaza_id, primary_key: :plaza_id
  has_many :postulants, foreign_key: :plaza_id, primary_key: :plaza_id


  def formal_name
    [post_name, identifier].join(' | ')
  end

  def has_indispensable?
    (plaza_degrees.indispensable.count + plaza_specialties.indispensable.count + plaza_languages.indispensable.count) > 0
  end

  def gra_codes
    plaza_degrees.indispensable.pluck(:gra_code)
  end

  def esp_codes
    plaza_specialties.indispensable.pluck(:esp_code)
  end

  def idi_codes
    plaza_languages.indispensable.pluck(:idi_code)
  end

  def applications_total
      stpp_apply_counter + spta_apply_counter
  end

  def total_salary
    (salary * vacancies) rescue 0
  end

  def self.random_id
    active.where(:plaza_state_id => 2).ids.sort_by{rand}.first
  end

  def self.twt_job
    r   = "#EmpleosSV http://www.empleospublicos.gob.sv #GobSV"
    job = find(self.random_id)

    if (job.nil?) or (job.post_name.blank?) or (job.post_name.blank?)
      self.twt_job
    else
      job_name = job.post_name.truncate(80)
      job_code = job.institution_code
      job_url  = "empleospublicos.gob.sv/jobs/#{job.id}"
      r        = job_name + " " + job_url +  " " + job_code + " #EmpleosSV"
    end
    r
  end

  def assigned_score_academic
    @assigned_score_academic ||= ::Employments::PostulantEvaluation.where(postulant_id: postulant_ids).where(factor_id: 1).first.try(:assigned_score)
  end
  def assigned_score_technique
    @assigned_score_technique ||= ::Employments::PostulantEvaluation.where(postulant_id: postulant_ids).where(factor_id: 5).first.try(:assigned_score)
  end
  def assigned_score_behavior
    @assigned_score_behavior ||= ::Employments::PostulantEvaluation.where(postulant_id: postulant_ids).where(factor_id: 6).first.try(:assigned_score)
  end
  def assigned_score_interview
    @assigned_score_interview ||= ::Employments::PostulantEvaluation.where(postulant_id: postulant_ids).where(factor_id: 7).first.try(:assigned_score)
  end

  def postulant_ids
    @postulant_ids ||= postulants.pluck(:id)
  end

end
