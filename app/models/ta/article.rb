class Ta::Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  acts_as_taggable

  has_attached_file :image,
                    styles: { small: '200x150>', medium: '552x414>', large: '1140x760>' },
                    default_url: 'ta/missing.jpg'

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :category, class_name: '::Ta::Category'
  belongs_to :author, class_name: '::Ta::Author'

  has_many :images, class_name: '::Ta::Image', as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :comments, class_name: '::Ta::Comment'

  enum status: [:draft, :publish]

  self.per_page = 10

  scope :gallery, lambda { includes(:images).where.not('ta_images.id' => nil) }
  scope :publish, -> { where(status: statuses[:publish]) }
  scope :newer, -> { order(published_at: :desc) }
  scope :yesterday, -> { where('published_at BETWEEN ? AND ?', Date.yesterday.beginning_of_day, Date.yesterday.end_of_day) }

  def gallery?
    images.count > 0
  end
end
