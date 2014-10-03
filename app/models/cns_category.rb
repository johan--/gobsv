class CnsCategory < ActiveRecord::Base

  has_many :cns_proposals, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
