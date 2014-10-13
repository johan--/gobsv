class CnsProposal < ActiveRecord::Base

  belongs_to :cns_category
  has_paper_trail

  validates :cns_category_id, presence: true
  validates :priority, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :cns_comments, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def as_json(options = {})
    super.as_json(options).merge(cns_category: cns_category)
  end
end
