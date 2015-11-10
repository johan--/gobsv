class Req::ProductRequirement < ActiveRecord::Base

  belongs_to :requirement, class_name: '::Req::Requirement'
  belongs_to :product,     class_name: '::Inv::Product'

  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
