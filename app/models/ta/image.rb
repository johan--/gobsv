module Ta
  class Image < ActiveRecord::Base
    belongs_to :imageable

    has_attached_file :image, styles: {
      small:  '300x300>',
      medium: '550x550>',
      large:  '1140x760>'
    }

    validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

    validates :description, presence: true
    validates :priority, presence: true, numericality: { only_integer: true }
  end
end
