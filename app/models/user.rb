class User < ActiveRecord::Base
  ##
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :user_authorizations, dependent: :destroy

  has_many :references, class_name: '::Employments::UserReference', dependent: :destroy
  has_many :personal_references, -> {where(kind: 2)}, class_name: '::Employments::UserReference', dependent: :destroy
  accepts_nested_attributes_for :references, allow_destroy: true

  has_many :specialties, class_name: '::Employments::UserSpecialty', dependent: :destroy
  accepts_nested_attributes_for :specialties, allow_destroy: true

  has_many :work_experiences, class_name: '::Employments::UserWorkExperience', dependent: :destroy
  accepts_nested_attributes_for :work_experiences, allow_destroy: true

  has_many :trainings, class_name: '::Employments::UserTraining', dependent: :destroy
  accepts_nested_attributes_for :trainings, allow_destroy: true

  has_many :languages, class_name: '::Employments::UserLanguage', dependent: :destroy
  accepts_nested_attributes_for :languages, allow_destroy: true

  has_many :disabilities, class_name: '::Employments::UserDisability', dependent: :destroy
  accepts_nested_attributes_for :disabilities, allow_destroy: true

  has_many :skills, class_name: '::Employments::UserSkill', dependent: :destroy
  accepts_nested_attributes_for :skills, limit: 20, allow_destroy: true


  has_many :user_postulations, class_name: '::Employments::UserPostulation', dependent: :destroy
  has_many :plazas, class_name: '::Employments::Plaza', through: :user_postulations, dependent: :destroy

  # Validations
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :on => :create
  validates :name, :presence => true
  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :password, :presence => true, :confirmation => true, :if => Proc.new{|o| o.password.present?}
  validates :document_number, uniqueness: true, on: :update
  validates :name, :last_name, :email, length: { maximum: 150 }
  validates :phone, :alt_phone, length: { maximum: 20 }
  validates :address, length: { maximum: 300 }
  validates :tax_id, length: { maximum: 17 }
  validates :document_number, length: { maximum: 17 }

  #validates :tax_id, :presence => true, length: { is: 17 }, :unless => :create

  # Callbacks
  # after_save :send_user_info_to_api

  include Humanizer
  require_human_on :create

  #User::Gender
  Gender = {
    '1' => 'Femenino',
    '2' => 'Masculino',
  }

  Treatment = {
    '1' => 'Sra.',
    '2' => 'Srta.',
    '3' => 'Sr.'
  }

  DocumentType = {
    :dui => 'DUI',
    :resident_card => 'Carnet de Residente',
    #:passport => 'Pasaporte'
  }

  def self.new_with_session(params,session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # Attempt to find a user by its reset_password_token to reset its
  # password. If a user is found and token is still valid, reset its password and automatically
  # try saving the record. If not user is found, returns a new user
  # containing an error in reset_password_token attribute.
  # Attributes must contain reset_password_token, password and confirmation
  def self.reset_password_by_token(attributes={})
    original_token       = attributes[:reset_password_token]
    reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)
    puts "============#{reset_password_token}"
    recoverable = find_or_initialize_with_error_by(:reset_password_token, reset_password_token)

    if recoverable.persisted?
      if recoverable.reset_password_period_valid?
        recoverable.reset_password(attributes[:password], attributes[:password_confirmation])
      else
        recoverable.errors.add(:reset_password_token, :expired)
      end
    end

    recoverable.reset_password_token = original_token if recoverable.reset_password_token.present?
    recoverable
  end

  def self.from_omniauth(auth, current_user)
#
    user_authorization = UserAuthorization.where(provider: auth.provider, uid: auth.uid.to_s).first_or_initialize
    user_authorization.update_column(:token, auth.credentials.token)
    user_authorization.update_column(:secret, auth.credentials.secret)

    if user_authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0, 10]
        user.name = auth.info.name
        user.email = auth.info.email
        auth.provider == 'twitter' ?  user.save(validate: false) : user.save
      end

      user_authorization.username = auth.info.nickname
      user_authorization.user_id = user.id
      user_authorization.save
    end
    user_authorization.user
  end

  def gender_s
    case gender
    when '1'
      return 'F'
    else
      return 'M'
    end
  end

  def document_code
    case document_type.to_s
    when 'dui'
      return 0
    else
      return 1
    end
  end

  def document_number_clean(is_dui = true)
    if is_dui
      if document_type.to_s == 'dui'
        document_number.gsub(/[^0-9]/i, '') rescue ""
      else
        ""
      end
    else
      if document_type.to_s == 'dui'
        ""
      else
        document_number.gsub(/[^0-9]/i, '') rescue ""
      end
    end
  end

  def formal_name
    [Treatment[treatment], name, last_name].join(' ')
  end

  def gra_codes
    specialties.pluck(:gra_code)
  end

  def esp_codes
    specialties.pluck(:esp_code)
  end

  def idi_codes
    languages.all.map(&:code)
  end

  def can_apply?(plaza)
    return false if stpp_id.nil?
    @can_apply ||= (plaza.idi_codes.blank? || (plaza.idi_codes & idi_codes).any?) && (plaza.gra_codes.blank? || (plaza.gra_codes & gra_codes).any?) && (plaza.esp_codes.blank? || (plaza.esp_codes & esp_codes).any?)
  end

  def cv_valid?
    specialties.any? && personal_references.any? && document_number.present? && country_id.present?
  end

  private
  def password_required?
    new_record? ? super : false
  end

  def send_user_info_to_api
    SynchronizeUsersJob.perform_later self
  end

end
