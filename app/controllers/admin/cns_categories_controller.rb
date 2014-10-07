class Admin::CnsCategoriesController < Admin::TabledController

  def model
    CnsCategory
  end

  def item_params
    params.require(:cns_category).permit(:name, :description, :icon)
  end
end
