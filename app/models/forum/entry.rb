require 'forum'
class Forum::Entry < ActiveRecord::Base
  acts_as_taggable
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_attached_file :asset
  do_not_validate_attachment_file_type :asset

  belongs_to :actor, class_name: '::Forum::Actor'
  belongs_to :organization, class_name: '::Forum::Organization'
  belongs_to :theme, class_name: '::Forum::Theme'

  default_scope { order(entry_at: :desc) }

  KIND = {
    'article' => 'Articulo',
    'document' => 'Documento',
    'video' => 'Video',
    'image' => 'Imagen',
    'twitter' => 'Twitter',
    'facebook' => 'Facebook'
  }

  validates :organization_id, :theme_id, :kind, :entry_at, presence: true

end
