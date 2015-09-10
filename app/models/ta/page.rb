require 'ta'
module Ta
  class Page < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

    enum position: [:top_header, :top_footer, :bottom_footer]
  end
end
