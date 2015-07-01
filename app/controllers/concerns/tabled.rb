module Tabled
  extend ActiveSupport::Concern

  included do
    respond_to :html, :json

    before_filter :init_breadcrumb

    helper_method :edit_item_url
    helper_method :index_url
    helper_method :item_url
    helper_method :model
    helper_method :namespace
    helper_method :new_item_url
    helper_method :table_columns
  end

  def init_breadcrumb
    add_breadcrumb I18n.t('layouts.admin.breadcrumb.home'), admin_root_url
  end

  def conditions(conditions = {})
    conditions
  end

  def namespace
    :admin
  end

  def model
    raise NoTypeGivenError
  end

  def index_url
    url_for action: :index
  end

  def item_url(id)
    url_for action: :show, id: id
  end

  def edit_item_url(id)
    url_for action: :edit, id: id
  end

  def new_item_url
    url_for action: :new
  end

  def init_form
  end

  def table_columns
    []
  end

  def index
    @items = model.where(conditions).decorate
    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html { render template: 'concerns/tabled/index' }
      format.json { render json: @items }
    end
  end

  def show
    @item = model.find params[:id]
    add_breadcrumb model.model_name.human(count: :many), index_url
    add_breadcrumb t('layouts.admin.breadcrumb.show')
  end

  def new
    @item = model.new
    init_form
    add_breadcrumb model.model_name.human(count: :many), index_url
    add_breadcrumb t('layouts.admin.breadcrumb.new')

    render template: 'concerns/tabled/new'
  end

  def create
    @item = model.new item_params

    if @item.save
      redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.admin.notice.created')
    else
      init_form
      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.admin.breadcrumb.new')

      render template: 'concerns/tabled/new'
    end
  end

  def edit
    @item = model.find params[:id]
    init_form
    add_breadcrumb model.model_name.human(count: :many), index_url
    add_breadcrumb t('layouts.admin.breadcrumb.edit')

    render template: 'concerns/tabled/edit'
  end

  def update
    @item = model.find params[:id]
    if @item.update_attributes item_params
      redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.admin.notice.updated')
    else
      init_form
      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.admin.breadcrumb.edit')
      render template: 'concerns/tabled/edit'
    end
  end

  def destroy
    model.find(params[:id]).destroy
    redirect_to url_for(action: :index), notice: t('layouts.admin.notice.deleted')
  end
end
