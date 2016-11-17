class Ind::NoteKind < ActiveRecord::Base

  has_many :notes, class_name: '::Ind::Note'
  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
