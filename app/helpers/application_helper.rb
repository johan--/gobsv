module ApplicationHelper
  include Twitter::Autolink

  def attribute_error(object, attribute)
    if object.errors.any?
      if object.errors.include? attribute
        attribute_errors = object.errors.get(attribute)
        if attribute_errors.kind_of?(Array)
          error = attribute_errors.first
        else
          error = attribute_errors
        end
        error = "#{t("activerecord.attributes.#{object.class.to_s.underscore}.#{attribute}")} #{error}"
        content_tag :div, class: 'has-error' do
          concat content_tag(:span, error, class: 'help-block')
        end
      end
    end
  end

  def flash_helper
    content_tag :div, class: "flash-messages" do
      flash.map do |key, value|
        content_tag :div, class: "alert alert-dismissable alert-#{key}" do
          content_tag(:span, '&times;'.html_safe, class: :close, 'data-dismiss' => 'alert') + value
        end
      end.join().html_safe
    end
  end

  def ErrorDisplayer

  end
end
