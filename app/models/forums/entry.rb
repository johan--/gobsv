class Forums::Entry < ActiveRecord::Base
  acts_as_taggable
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_attached_file :asset
  do_not_validate_attachment_file_type :asset

  belongs_to :actor
  belongs_to :organization
  belongs_to :theme

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
