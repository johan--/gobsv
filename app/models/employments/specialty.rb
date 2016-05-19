class Employments::Specialty < ActiveRecord::Base

  scope :grades, -> { select('DISTINCT ON (employments_specialties.gra_code) *').order(:gra_code) }


  def gra_specialties
    Employments::Specialty.where(gra_code: gra_code).order(:priority, :esp_name)
  end

  def self.grouped_box
    ::Employments::Specialty.order(:gra_code, :esp_code).group_by{|obj| obj.gra_name}.collect{|obj|
      [
        obj[0],
        obj[1].collect{|esp| [esp.esp_name.try(:capitalize), esp.esp_code]}
      ]
    }
  end

end
