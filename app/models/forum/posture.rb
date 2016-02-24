require 'forum'
class Forum::Posture < ActiveRecord::Base
  belongs_to :actor, class_name: '::Forum::Actor'
  belongs_to :organization, class_name: '::Forum::Organization'
  belongs_to :entry, class_name: '::Forum::Entry'
  belongs_to :theme, class_name: '::Forum::Theme'

  scope :latest, -> { select('DISTINCT ON(forums_postures.organization_id) *').order('organization_id, quoted_at DESC') }

  validates :organization_id, :actor_id, :theme_id, :quote, :quoted_at, presence: true
  validates :quote, length: { maximum: 500 }
end
