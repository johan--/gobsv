class Admin::Inv::ProductMovementsController < Admin::TaController

  def model
    ::Inv::ProductMovement
  end

  def create
    @item = model.new item_params
    @item.admin = current_admin

    if @item.save
      redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.admin.notice.created')
    else
      init_form
      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.admin.breadcrumb.new')

      render template: 'concerns/tabled/new'
    end
  end

  def index
    @items = model.select("
      inv_product_movements.*,
      inv_products.code AS product_code,
      inv_products.name AS product_name,
      inv_warehouses.name AS warehouse_name,
      admins.name AS admin_name
    ")
    .joins(:product)
    .joins(:warehouse)
    .joins(:admin)
    .where(conditions)
    .order(created_at: :desc)
    .decorate

    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html { render template: 'admin/inv/product_movements/index' }
      format.json { render json: @items }
    end
  end

  def table_columns
    %w(admin_name created_at product_code product_name warehouse_name kind cause quantity comments)
  end

  def init_form
    @products   = ::Inv::Product.order :name
    @warehouses = ::Inv::Warehouse.order :name
  end

  def item_params
    params.require(:inv_product_movement).permit(
      :product_id,
      :warehouse_id,
      :warehouse_from,
      :quantity,
      :cause,
      :kind,
      :comments
    )
  end
end
