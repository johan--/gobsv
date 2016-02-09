class Forums::Entry < ActiveRecord::Base
  acts_as_taggable
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_attached_file :asset
  do_not_validate_attachment_file_type :asset

  belongs_to :actor, class_name: '::Forums::Actor'
  belongs_to :organization, class_name: '::Forums::Organization'
  belongs_to :theme, class_name: '::Forums::Theme'

  default_scope { order(entry_at: :asc) }

  KIND = {
    'articulo' => 'Articulo',
    'document' => 'Documento',
    'video' => 'Video',
    'image' => 'Imagen',
    'twitter' => 'Twitter',
    'facebook' => 'Facebook'
  }

  validates :organization_id, :theme_id, :kind, :entry_at, presence: true

end
