class User < ActiveRecord::Base

  ##
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :user_authorizations, dependent: :destroy

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
        auth.provider == 'twitter' ?  user.save(validate: false) :  user.save
      end

      user_authorization.username = auth.info.nickname
      user_authorization.user_id = user.id
      user_authorization.save
    end
    user_authorization.user
  end
end
