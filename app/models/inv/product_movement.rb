class Inv::ProductMovement < ActiveRecord::Base

  belongs_to :product,   class_name: '::Inv::Product'
  belongs_to :warehouse, class_name: '::Inv::Warehouse'
  belongs_to :admin,     class_name: 'Admin'

  enum kind:    [:in, :out]
  enum cause:   [:purchase, :adjustment, :transfer, :request]

  validates :product_id, presence: true
  validates :warehouse_id, presence: true, exclusion: { in: Proc.new { |o| [o.warehouse_from] }}
  validates :warehouse_from, presence: true, if: Proc.new { |o| o.transfer? }
  validates :kind, presence: true
  validates :cause, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  ##
  after_create :transferences
  #
  def transferences
    if transfer? && in?
      self.class.create admin_id: admin_id,
        cause: :transfer,
        comments: 'Ajuste automático',
        kind: :out,
        product_id: product_id,
        quantity: quantity,
        warehouse_from: warehouse_id,
        warehouse_id: warehouse_from
    end
  end

end
