class Inv::Unit < ActiveRecord::Base

  has_many :products, class_name: '::Inv::Product'

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
