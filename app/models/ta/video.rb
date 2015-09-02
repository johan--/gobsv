class Ta::Video < ActiveRecord::Base
  belongs_to :article, class_name: '::Ta::Article'

  has_attached_file :image, styles: {
    small:  '300x300>',
    medium: '550x550>',
    large:  '1140x760>'
  }

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
end
