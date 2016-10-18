class Ind::Category < ActiveRecord::Base

  has_many :notes, class_name: '::Ind::Note'  
  validates :name,    presence: true, uniqueness: { case_sensitive: false }

  has_attached_file :picture, styles: {
  	icon: '50x50>',
    small:  '160x160>',
  }, default_url: 'indicators/sabesqueazul.png'

  validates_attachment_content_type :picture, content_type: %r{\Aimage\/.*\Z}

end
