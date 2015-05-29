class Ta::Image < ActiveRecord::Base
  belongs_to :imageable

  has_attached_file :image, styles: { small: '100x100>', medium: '300x300>', large: '1140x760>' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
