class Pensions::SubscriberDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :default
  end
end
