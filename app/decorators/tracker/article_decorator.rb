class Tracker::ArticleDecorator < Draper::Decorator
  delegate_all

  def created_at
    unless object.created_at.nil?
      h.l object.created_at, format: :sortable
    end
  end
  
  def publish_date
    unless object.publish_date.nil?
      h.l object.publish_date, format: :sortable
    end
  end

  def author_id
    unless object.author.nil?
      object.author.name
    end
  end
  
  def status_id
    unless object.status.nil?
      "#{object.status.status.name} / #{object.status.name}"
    end
  end

end
