class Employments::UserSpecialty < ActiveRecord::Base
  belongs_to :user

  validates :esp_code, :country_id, :institution_name, :start_at, :end_at, presence: true

  has_attached_file :certificate
  #do_not_validate_attachment_file_type :certificate
  validates_attachment_presence :certificate
  validates_attachment_content_type :certificate, content_type: ['application/pdf'], message: 'por favor adjunte un archivo en formato PDF'

  before_save :set_missing_data

  ACADEMIC_GRADE = {
    '01' => "1° y 2° CICLO DE EDUCACION BASICA (6° GRADO)",
    '02' => "3° CICLO DE EDUCACION BASICA (9° GRADO)",
    '03' => "BACHILLER GENERAL",
    '04' => "BACHILLER TECNICO VOCACIONAL",
    '05' => "TECNICO",
    '65' => "ESTUDIANTE UNIVERSITARIO (1° ANO - 3° ANO)",
    '06' => "ESTUDIANTE UNIVERSITARIO (4° ANO O MAS)",
    '07' => "EGRESADO UNIVERSITARIO",
    '08' => "GRADUADO UNIVERSITARIO",
    '09' => "DIPLOMADO",
    '11' => "MAESTRIA",
    '12' => "DOCTORADO",
    '59' => "MAYOR",
    '64' => "CAPITAN",
    '67' => "CAPELLAN",
    '69' => "BACHILLER COMERCIAL",
    '72' => "TECNOLOGO",
    '73' => "ESPECIALISTA EN MEDICINA",
    '74' => "ESPECIALISTA EN ODONTOLOGIA"
  }

  def set_missing_data
    self.esp_name = ::Employments::Specialty.active.where(esp_code: self.esp_code).limit(1).first.try(:esp_name)
    self.name = ::Employments::Specialty.active.where(gra_code: self.gra_code).limit(1).first.try(:gra_name)
  end

  def gra_specialties
    Employments::Specialty.active.where(gra_code: gra_code).order(:priority, :esp_name)
  end

  def self.dedupe
    # find all models and group them on keys which should be common
    grouped = all.group_by{|model| [model.esp_code,model.gra_code,model.user_id,model.country_id] }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # or pop for last one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy} # duplicates can now be destroyed
    end
  end

end
