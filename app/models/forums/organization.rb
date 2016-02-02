class Forums::Organization < ActiveRecord::Base
  has_attached_file :logo,
                    styles: {
                      small:  'x16>'
                    },
                    default_url: 'ta/missing.jpg'

  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  validates :name, :kind, presence: true

  KIND = {
    'media' => 'Medio de comunicación',
    'politic' => 'Partido politico',
    'private' => 'Empresa privada',
    'society' => 'Sociedad civil',
    'ong' => 'ONG',
    'other' => 'Otro'
  }
end
