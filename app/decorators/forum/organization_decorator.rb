class Forum::OrganizationDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def kind
    Forum::Organization::KIND[self[:kind]]
  end

  def created_at
    h.l object.created_at, format: :default
  end

end
