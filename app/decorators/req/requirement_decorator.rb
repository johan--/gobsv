class Req::RequirementDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.l object.created_at, format: :sortable
  end

  def status
    h.t("activerecord.enum.req/requirement.status.#{object.status}")
  end
end
