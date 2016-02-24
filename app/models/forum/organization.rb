require 'forum'
class Forum::Organization < ActiveRecord::Base
  has_attached_file :logo,
                    styles: {
                      small:  'x16>'
                    },
                    default_url: 'ta/missing.jpg'

  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  validates :name, presence: true

  KIND = {
    'private' => 'Empresa privada',
    'gov' => 'Instituciones del Estado',
    'media' => 'Medio de comunicación',
    'ong' => 'ONG',
    'politic' => 'Partido politico',
    'society' => 'Sociedad civil',
    'other' => 'Otros'
  }
end
