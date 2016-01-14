class Ta::CommentDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :sortable
  end

  def status
    I18n.t("activerecord.enum.ta/comment.status.#{object.status}")
  end
end
