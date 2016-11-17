class Admin::Msg::GroupsController < Admin::MsgController

  def model
    ::Msg::Group
  end

  def table_columns
    %w(name)
  end

  def init_form
  end

  def index
    @items = model
    .order(name: :asc)
    .decorate

    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html { render template: 'concerns/tabled/index' }
      format.json { render json: @items }
    end
  end

  def before_controller_create
    # @item.admin = current_admin
  end

  def item_params
    # params[:req_requirement] ||= {}
    # params[:req_requirement][:product_requirements_attributes] ||= {}
    #
    params.require(:msg_group).permit(
      :name,
      :asset,
      :modify
    )
  end

end
