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
end
