class Ofcia::PayrollDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :sortable
  end

  def fecha_presentacion_planilla
    h.l object.fecha_presentacion_planilla, format: :sortable
  end
end
