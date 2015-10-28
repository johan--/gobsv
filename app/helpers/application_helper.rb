module ApplicationHelper
  include Twitter::Autolink

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
