class Ta::Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :articles, class_name: '::Ta::Article'
end
