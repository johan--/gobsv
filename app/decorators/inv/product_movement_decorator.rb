class Inv::ProductMovementDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :sortable
  end

  def cause
    h.t("activerecord.enum.inv/product_movement.cause.#{object.cause}")
  end

  def kind
    h.t("activerecord.enum.inv/product_movement.kind.#{object.kind}")
  end
end
