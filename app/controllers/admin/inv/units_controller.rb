class Admin::Inv::UnitsController < Admin::InvController

  def model
    ::Inv::Unit
  end

  def table_columns
    %w(name)
  end

  def item_params
    params.require(:inv_unit).permit(
      :name
    )
  end
end
