class Admin::Ta::PagesController < Admin::TaController

  def model
    ::Ta::Page
  end

  def table_columns
    %w(name position)
  end

  def item_params
    params.require(:ta_page).permit(
      :priority,
      :name,
      :content,
      :position
    )
  end
end
