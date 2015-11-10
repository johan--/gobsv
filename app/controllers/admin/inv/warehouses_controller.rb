class Admin::Inv::WarehousesController < Admin::InvController

  def model
    ::Inv::Warehouse
  end

  def table_columns
    %w(name)
  end

  def init_form
    @products = ::Inv::Product.order :name
  end

  def item_params
    params.require(:inv_warehouse).permit(
      :name
    )
  end
end
