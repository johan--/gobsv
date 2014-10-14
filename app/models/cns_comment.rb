class CnsComment < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true
  validates :name, :email, presence: true, if: :no_user?

  def no_user?
    user_id.blank?
  end
end
