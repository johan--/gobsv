class CnsEvent < ActiveRecord::Base

  has_paper_trail

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :event_date, presence: true
  validates :event_date, date: true
end
