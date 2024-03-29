class Forum::EntryDecorator < Draper::Decorator
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

  def kind
    Forum::Entry::KIND[self[:kind]]
  end

  def created_at
    h.l object.created_at, format: :default
  end

  def entry_at
    h.l object.entry_at, format: :default
  end

end
