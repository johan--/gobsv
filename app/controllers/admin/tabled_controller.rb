class Admin::TabledController < AdminController

  respond_to :html, :json
  before_filter :init_breadcrumb

  def init_breadcrumb
    add_breadcrumb I18n.t("layouts.admin.breadcrumb.home"), admin_root_url
  end

  def namespace
    :admin
  end
  helper_method :namespace

  def model
    raise NoTypeGivenError
  end
  helper_method :model

  def index_url
    url_for action: :index
  end
  helper_method :index_url

  def item_url id
    url_for action: :show, id: id
  end
  helper_method :item_url

  def edit_item_url id
    url_for action: :edit, id: id
  end
  helper_method :edit_item_url

  def new_item_url
    url_for action: :new
  end
  helper_method :new_item_url

  def init_form
  end

  def index
    @items = model.all
    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    respond_with @items
  end

  def show
    @item = model.find params[:id]
    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    add_breadcrumb t("layouts.admin.breadcrumb.show")
  end

  def new
    @item = model.new
    init_form
    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    add_breadcrumb t("layouts.admin.breadcrumb.new")
  end

  def create
    @item = model.new item_params
    if @item.save
      redirect_to url_for(action: :show, id: @item.id), notice: :created
    else
      init_form
      add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
      add_breadcrumb t("layouts.admin.breadcrumb.new")
      render action: :new
    end
  end

  def edit
    @item = model.find params[:id]
    init_form
    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    add_breadcrumb t("layouts.admin.breadcrumb.edit")
  end

  def update
    @item = model.find params[:id]
    if @item.update_attributes item_params
      redirect_to url_for(action: :show, id: @item.id), notice: :updated
    else
      init_form
      add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
      add_breadcrumb t("layouts.admin.breadcrumb.edit")
      render action: :edit
    end
  end

  def destroy
    model.find(params[:id]).destroy
    redirect_to url_for(action: :index), notice: :deleted
  end

end
