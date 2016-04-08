class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_closure_tree

  validates :name, presence: true

  belongs_to :role

  delegate :institution_id, to: :role, allow_nil: true, allow_prefix: true

  def admin?
    role.try(:institution_id).blank?
  end

  def oficial?
    role_id.present?
  end

  def active_for_authentication?
    super && self.is_active?
  end

  def inactive_message
    "Lo sentimos, esta cuenta ha sido desactivada."
  end

end
