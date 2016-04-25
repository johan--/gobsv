class Employments::UserSpecialty < ActiveRecord::Base
  belongs_to :user

  validates :gra_code, :esp_code, :country_id, :institution_name, :start_at, :end_at, presence: true

  has_attached_file :certificate
  #do_not_validate_attachment_file_type :certificate
  validates_attachment_presence :certificate
  validates_attachment_content_type :certificate, content_type: ['application/pdf']

  before_save :set_missing_data

  AcademicGrade = {
    1 => "1° y 2° CICLO DE EDUCACION BASICA (6° GRADO)",
    2 => "3° CICLO DE EDUCACION BASICA (9° GRADO)",
    3 => "BACHILLER GENERAL",
    4 => "BACHILLER COMERCIAL",
    5 => "BACHILLER TECNICO VOCACIONAL",
    6 => "ESTUDIANTE UNIVERSITARIO (1° AÑO - 3° AÑO)",
    7 => "ESTUDIANTE UNIVERSITARIO (4° AÑO O MAS)",
    8 => "EGRESADO UNIVERSITARIO",
    9 => "GRADUADO UNIVERSITARIO",
    10 => "TECNICO",
    11 => "MAESTRIA",
    12 => "CAPELLAN",
    14 => "DOCTORADO",
    15 => "ESPECIALISTA EN ODONTOLOGIA",
    16 => "ESPECIALISTA EN MEDICINA"
  }

  def set_missing_data
    self.esp_name = ::Employments::Specialty.select(:esp_name).where(esp_code: self.esp_code).limit(1).first.try(:esp_name)
    self.name = ::Employments::Specialty.select(:gra_name).where(gra_code: self.gra_code).limit(1).first.try(:gra_name)
  end

end
