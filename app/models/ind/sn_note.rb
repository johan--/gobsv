class Ind::SnNote < ActiveRecord::Base

  has_many :sn_note_images, class_name: '::Ind::SnNoteImage', dependent: :destroy
  accepts_nested_attributes_for :sn_note_images, limit: 4, allow_destroy: true

  belongs_to :note, class_name: '::Ind::Note'

  validates :description, :day, :hour, :minute, presence: true
  validates :description, length: { maximum: 140 }

end
