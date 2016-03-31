class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_closure_tree

  validates :name, presence: true

  belongs_to :role

  def oficial?
    role_id.present?
  end

end
