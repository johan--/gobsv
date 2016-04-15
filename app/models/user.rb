class User < ActiveRecord::Base
  ##
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :user_authorizations, dependent: :destroy

  has_many :references, class_name: '::Employments::UserReference', dependent: :destroy
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

  # Validations
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :name, :presence => true #:role_id
  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :password, :presence => true, :confirmation => true, :if => Proc.new{|o| o.password.present?}

  validates :tax_id, length: { is: 17 }
  
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
    :passport => 'Pasaporte'
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

  def self.from_omniauth(auth, current_user)

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

  private
  def password_required?
    new_record? ? super : false
  end  

end
