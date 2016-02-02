class Forums::Organization < ActiveRecord::Base
  has_attached_file :logo,
                    styles: {
                      small:  '34>'
                    },
                    default_url: 'ta/missing.jpg'

  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
end
