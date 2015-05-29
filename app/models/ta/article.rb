class Ta::Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  acts_as_taggable

  has_attached_file :image, styles: { small: '200x150>', medium: '400x300>', large: '1140x760>' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :category, class_name: '::Ta::Category'
  belongs_to :author, class_name: '::Ta::Author'

  has_many :images, class_name: '::Ta::Image', as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :comments, class_name: '::Ta::Comment'

  enum status: [:draft, :publish]

  def gallery?
    images.count > 0
  end
end
