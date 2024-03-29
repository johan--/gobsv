require 'ta'
module Ta
  class Category < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

    validates :name, presence: true

    has_many :articles, class_name: '::Ta::Article'
  end
end
