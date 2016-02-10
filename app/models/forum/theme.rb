require 'forum'
class Forum::Theme < ActiveRecord::Base
  has_many :postures, class_name: '::Forum::Posture'
  has_many :entries, class_name: '::Forum::Entry'

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_attached_file :cover,
                    styles: {
                      small:  '200x113#',
                      large:  '1600x532#'
                    },
                    default_url: 'ta/missing.jpg'

  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\Z}

  scope :active, -> { where(active: true) }
  scope :main, -> { where(main: true) }

  before_save :verify_main

  def verify_main
    Forum::Theme.where.not(id: self.id).update_all(main: false) if self.main?
  end
end
