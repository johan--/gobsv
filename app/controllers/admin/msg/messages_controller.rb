class Admin::Msg::MessagesController < Admin::MsgController

  def model
    ::Msg::Message
  end

  def table_columns
    %w(created_at name content group_id)
  end

  def init_form
  end

  def index
    @items = model
    .order(created_at: :desc)
    .decorate

    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end

  def before_controller_create
    # @item.admin = current_admin
  end

  def create
    @item = model.new item_params
    before_controller_create

    if @item.save
      redirect_to url_for(action: :index), notice: 'SMS enviado con éxito'
    else
      init_form
      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.admin.breadcrumb.new')

      render template: 'concerns/tabled/new'
    end
  end

  def item_params
    # params[:req_requirement] ||= {}
    # params[:req_requirement][:product_requirements_attributes] ||= {}
    #
    params.require(:msg_message).permit(
      :name,
      :group_id,
      :content
    )
  end

end
