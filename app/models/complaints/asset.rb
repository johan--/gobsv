class Complaints::Asset < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :expedient_managements
  has_and_belongs_to_many :expedient_management_comments

  has_attached_file :asset
  validates :asset, attachment_presence: true
  do_not_validate_attachment_file_type :asset

  scope :newer, -> { order(created_at: :desc) }

  def can_delete?
    expedient_managements.count == 0 and expedient_management_comments.count == 0
  end

end
