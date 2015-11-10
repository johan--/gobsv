class Admin::Inv::ProductsController < Admin::InvController

  def model
    ::Inv::Product
  end

  def table_columns
    %w(code name)
  end

  def init_form
    @units = Inv::Unit.order :name
    @warehouses = Inv::Warehouse.order :name
  end

  def item_params
    params.require(:inv_product).permit(
      :unit_id,
      :name
    )
  end
end
