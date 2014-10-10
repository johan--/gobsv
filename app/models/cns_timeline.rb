class CnsTimeline < ActiveRecord::Base
  has_paper_trail

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :timeline_date, presence: true
  validates :description, presence: true

  validates :timeline_date, date: true
end
