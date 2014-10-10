class CnsArticleDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  def article_date
    helpers.content_tag :div, class: 'article-date' do
      object.article_date.strftime("%d-%m-%y")
    end
  end

  def description
    helpers.content_tag :div, class: 'article-description' do
      object.description.truncate(250, omission: '...')
    end
  end

end
