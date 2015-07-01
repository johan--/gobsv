class Ta::Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  acts_as_taggable

  has_attached_file :image,
                    styles: { small: '200x113#', medium: '552x311#', large: '1140x641#' },
                    default_url: 'ta/missing.jpg'

                    # styles: Proc.new { |o| o.instance.resize }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :category, class_name: '::Ta::Category'
  belongs_to :author, class_name: '::Ta::Author'

  has_many :images, -> { order(:priority) }, class_name: '::Ta::Image', as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :comments, class_name: '::Ta::Comment'

  enum status: [:draft, :publish]

  self.per_page = 10

  scope :gallery,   lambda { includes(:images).where.not('ta_images.id' => nil) }
  scope :publish,   -> { where(status: statuses[:publish]).where('published_at < ?', Time.zone.now) }
  scope :featured,  -> { where(featured: true) }
  scope :newer,     -> { order(published_at: :desc) }
  scope :yesterday, -> { where('published_at BETWEEN ? AND ?', Date.yesterday.beginning_of_day, Date.yesterday.end_of_day) }

  def gallery?
    images.count > 0
  end

  def resize
    begin
      styles = {}
      [
        :small,
        :medium,
        :large,
        :original
      ].each do |style|

        geo    = Paperclip::Geometry.from_file(Rails.root.join("public/system/ta/articles/images/#{("%09d" % id).scan(/\d{3}/).join("/")}/#{style}/#{image_file_name}").to_s)
        width  = geo.width
        height = geo.height

        if width / height > 1.78
          width  = height * 16 / 9
          styles[style] = "#{width.to_i}#x#{height.to_i}"
        else
          height = width * 9 / 16
          styles[style] = "#{width.to_i}x#{height.to_i}#"
        end
      end
      return styles

    rescue
      return { small: '200x113#', medium: '552x311#', large: '1140x641#', original: '1140x641#' }
    end
  end
end
