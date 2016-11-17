class Ind::Note < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :sn_note, class_name: '::Ind::SnNote', dependent: :destroy

  belongs_to :category, class_name: '::Ind::Category'
  belongs_to :note_kind, class_name: '::Ind::NoteKind'

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :category_id, :content, presence: true

end