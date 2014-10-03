class CnsEvent < ActiveRecord::Base

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :event_date, presence: true
  validates :event_date, date: true
end
