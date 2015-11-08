class Inv::Warehouse < ActiveRecord::Base
  has_many :product_stocks, class_name: '::Inv::ProductStock'

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
