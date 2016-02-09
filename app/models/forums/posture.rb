require 'forums'
module Forums
  class Posture < ActiveRecord::Base
    belongs_to :actor
    belongs_to :organization
    belongs_to :entry
    belongs_to :theme

    scope :latest, -> { select('DISTINCT ON(forums_postures.organization_id) *').order('organization_id, quoted_at DESC') }

    validates :organization_id, :actor_id, :theme_id, :quote, :quoted_at, presence: true
    validates :quote, length: { maximum: 500 }
  end
end
