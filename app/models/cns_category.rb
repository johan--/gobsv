class CnsCategory < ActiveRecord::Base

  has_many :cns_proposals, dependent: :destroy
  has_paper_trail

  has_attached_file :icon, styles: { icon: '32x32>' }
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
