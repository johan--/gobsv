class CnsTimeline < ActiveRecord::Base
  has_paper_trail

  validates :name, :timeline_date, :description, presence: true

  validates :timeline_date, date: true
end
