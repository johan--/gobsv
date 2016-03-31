class Complaints::Asset < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :expedient_managements,
    join_table: :complaints_expedient_managements_complaints_assets,
    class_name: '::Complaints::ExpedientManagement',
    foreign_key: 'complaints_asset_id',
    association_foreign_key: 'complaints_expedient_management_id'

  has_attached_file :asset
  validates :asset, attachment_presence: true
  do_not_validate_attachment_file_type :asset

  scope :newer, -> { order(created_at: :desc) }

  def can_delete?
    expedient_managements.count == 0
  end

end
