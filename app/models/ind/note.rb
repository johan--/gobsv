class Ind::Note < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :sn_note, class_name: '::Ind::SnNote', dependent: :destroy
  belongs_to :category, class_name: '::Ind::Category'

  validates :title,    presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true

end
