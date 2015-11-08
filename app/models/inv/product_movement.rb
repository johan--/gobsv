class Inv::ProductMovement < ActiveRecord::Base

  attr_accessor :warehouse_from

  belongs_to :product,   class_name: '::Inv::Product'
  belongs_to :warehouse, class_name: '::Inv::Warehouse'
  belongs_to :admin,     class_name: 'Admin'

  enum kind:  [:in, :out]
  enum cause: [:purchase, :adjustment, :transfer, :request]

  validates :product_id, presence: true
  validates :warehouse_id, presence: true
  validates :warehouse_from, presence: true, if: Proc.new { |o| o.transfer? }
  validates :kind, presence: true
  validates :cause, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
