class CnsEventDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  def event_date
    helpers.content_tag :div, class: 'event-date' do
      helpers.content_tag :div, class: 'event-day' do
        object.event_date.strftime("%d %b")
      end
    end
  end

  def description
    helpers.content_tag :div, class: 'event-description' do
      object.description.truncate(150, omission: '...')
    end
  end

end
