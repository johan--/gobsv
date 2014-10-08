class CnsArticle < ActiveRecord::Base

  has_paper_trail

  has_attached_file :picture, styles: { medium: '386x160>' }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :article_date, presence: true
  validates :article_date, date: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
