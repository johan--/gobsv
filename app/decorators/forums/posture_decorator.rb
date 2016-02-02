class Forums::PostureDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def organization_id
    organization.try(:name)
  end

  def actor_id
    actor.try(:name)
  end

  def theme_id
    theme.try(:name)
  end

  def quoted_at
    h.l object.quoted_at, format: :default if self[:quoted_at]
  end

  def quote
    h.truncate(self[:quote], length: 50)
  end

end
