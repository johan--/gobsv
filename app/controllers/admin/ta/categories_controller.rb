class Admin::Ta::CategoriesController < Admin::TaController

  def model
    ::Ta::Category
  end

  def table_columns
    %w(name)
  end

  def item_params
    params.require(:ta_category).permit(
      :name
    )
  end
end
