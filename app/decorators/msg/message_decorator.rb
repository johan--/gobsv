class Msg::MessageDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  def created_at
    object.created_at.strftime("%d/%m/%Y %H:%M")
  end

  def group_id
    group.full_name
  end

end
