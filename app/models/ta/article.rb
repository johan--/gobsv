require 'ta'
module Ta
  class Article < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

    acts_as_taggable

    has_attached_file :image,
                      styles: {
                        small:  '200x113#',
                        medium: '552x311#',
                        large:  '1140x641#'
                      },
                      default_url: 'ta/missing.jpg'

    validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

    belongs_to :category, class_name: '::Ta::Category'
    belongs_to :author,   class_name: '::Ta::Author'

    has_many :images,
             -> { order(:priority) },
             class_name: '::Ta::Image',
             as: :imageable

    accepts_nested_attributes_for :images, allow_destroy: true

    has_many :videos, -> { order(:priority) }, class_name: '::Ta::Video'
    accepts_nested_attributes_for :videos, allow_destroy: true

    has_many :audios, -> { order(:priority) }, class_name: '::Ta::Audio'
    accepts_nested_attributes_for :audios, allow_destroy: true

    has_many :comments, class_name: '::Ta::Comment'

    enum status: [:draft, :publish]
    enum layout: [:normal, :gallery, :audio, :video]

    def youtubeid
      {
        1 => %r{youtu\.be\/([^\?]*)},
        5 => %r{^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*}
      }.each do |position, regex|
        matches = video_url.match(regex)
        return matches[position] unless matches.nil?
      end
      nil
    end

    self.per_page = 10

    scope :with_images,
          -> { includes(:images).where.not('ta_images.id' => nil) }

    scope :publish,
          lambda {
            where(status: statuses[:publish])
              .where('published_at < ?', Time.zone.now)
          }

    scope :yesterday,
          lambda {
            where(
              'published_at BETWEEN ? AND ?',
              Date.yesterday.beginning_of_day,
              Date.yesterday.end_of_day
            )
          }

    scope :featured,       -> { where(featured: true)             }
    scope :front,          -> { where(front: true)                }
    scope :newer,          -> { order(published_at: :desc)        }
    scope :gallery_layout, -> { where(layout: layouts[:gallery])  }
    scope :audio_layout,   -> { where(layout: layouts[:audio])    }
    scope :video_layout,   -> { where(layout: layouts[:video])    }
  end
end
