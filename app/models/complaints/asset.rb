class Complaints::Asset < ActiveRecord::Base
  belongs_to :user

  has_attached_file :asset
  validates :asset, attachment_presence: true
  do_not_validate_attachment_file_type :asset
end
