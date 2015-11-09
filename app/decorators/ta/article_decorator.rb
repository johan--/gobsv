class Ta::ArticleDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :sortable
  end
end
