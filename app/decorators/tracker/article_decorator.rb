class Tracker::ArticleDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :sortable
  end
  
  def publish_date
    h.l object.publish_date, format: :sortable
  end

  def author_id
    object.author.name
  end
  
  def status_id
    unless object.status.nil?
      object.status.name
    end
  end

end
