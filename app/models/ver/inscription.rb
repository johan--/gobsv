class Ver::Inscription < ActiveRecord::Base

  validates :firstname, :lastname, :location, :email, :age, presence: true
  validate :has_space

  after_create :send_ver_inscription_mail

  def send_ver_inscription_mail
    UserMailer.ver_inscription_mail(self)
  end

  def has_space
    total = ::Ver::Inscription.where(location: location).count
    errors.add(:base, location.humanize + " ya tiene cupo lleno") if total >= 30
  end
end
