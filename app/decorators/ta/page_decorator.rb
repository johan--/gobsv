class Ta::PageDecorator < Draper::Decorator
  delegate_all

  def position
    I18n.t("activerecord.enum.ta/page.position.#{object.position}")
  end
end
