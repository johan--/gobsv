class CnsEvent < ActiveRecord::Base

  has_paper_trail

  has_attached_file :picture, styles: { medium: '386x160>' }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :event_date, presence: true
  validates :event_date, date: true

  scope :active, -> { where('event_date >= ?', Date.current) }
end
