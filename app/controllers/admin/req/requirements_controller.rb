class Admin::Req::RequirementsController < Admin::ReqController

  def model
    ::Req::Requirement
  end

  def table_columns
    %w(code admin_name status created_at)
  end

  def init_form
    @products = ::Inv::Product.order :name
  end

  def index
    @items = model.select("
      req_requirements.*,
      admins.name AS admin_name
    ")
    .joins(:admin)
    .order(created_at: :desc)
    .decorate

    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html { render template: 'concerns/tabled/index' }
      format.json { render json: @items }
    end
  end

  def before_controller_create
    @item.admin = current_admin
  end

  def item_params
    params[:req_requirement] ||= {}
    params[:req_requirement][:product_requirements_attributes] ||= {}

    params.require(:req_requirement).permit(
      product_requirements_attributes: [:id, :product_id, :quantity, :_destroy]
    )
  end
end
