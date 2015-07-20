class Ta::Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  acts_as_taggable

  has_attached_file :image,
                    styles: { small: '200x113#', medium: '552x311#', large: '1140x641#' },
                    default_url: 'ta/missing.jpg'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :category, class_name: '::Ta::Category'
  belongs_to :author, class_name: '::Ta::Author'

  has_many :images, -> { order(:priority) }, class_name: '::Ta::Image', as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :videos, -> { order(:priority) }, class_name: '::Ta::Video'
  accepts_nested_attributes_for :videos, allow_destroy: true

  has_many :audios, -> { order(:priority) }, class_name: '::Ta::Audio'
  accepts_nested_attributes_for :audios, allow_destroy: true

  has_many :comments, class_name: '::Ta::Comment'

  enum status: [:draft, :publish]
  enum layout: [:normal, :gallery, :audio, :video]

  def video_url_id
    if video_url[/youtu\.be\/([^\?]*)/]
      video_id = $1
    else
      video_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      video_id = $5
    end
    video_id
  end

  self.per_page = 10

  scope :with_images,    lambda { includes(:images).where.not('ta_images.id' => nil) }
  #scope :with_videos,    lambda { includes(:videos).where.not('ta_videos.id' => nil) }
  #scope :with_audios,    lambda { includes(:audios).where.not('ta_audios.id' => nil) }
  scope :publish,        -> { where(status: statuses[:publish]).where('published_at < ?', Time.zone.now) }
  scope :featured,       -> { where(featured: true) }
  scope :front,          -> { where(front: true) }
  scope :newer,          -> { order(published_at: :desc) }
  scope :yesterday,      -> { where('published_at BETWEEN ? AND ?', Date.yesterday.beginning_of_day, Date.yesterday.end_of_day) }
  scope :gallery_layout, -> { where(layout: layouts[:gallery]) }
  scope :audio_layout,   -> { where(layout: layouts[:audio])   }
  scope :video_layout,   -> { where(layout: layouts[:video])   }

end
