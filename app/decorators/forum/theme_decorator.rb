class Forum::ThemeDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :default
  end

  def active
    helpers.content_tag :span, class: object.active == true ? 'glyphicon glyphicon-ok' : 'glyphicon glyphicon-ban-circle', 'aria-hidden' => 'true' do
    end
  end

  def main
    helpers.content_tag :span, class: object.main == true ? 'glyphicon glyphicon-ok' : 'glyphicon glyphicon-ban-circle', 'aria-hidden' => 'true' do
    end
  end

end
