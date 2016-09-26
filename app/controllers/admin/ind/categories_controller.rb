class Admin::Ind::CategoriesController < Admin::IndController

  def model
    ::Ind::Category
  end

  def create
    @item = model.new item_params
    #@item.admin = current_admin

    if @item.save
      redirect_to url_for(action: :index), notice: t('layouts.admin.notice.created')
    else
      init_form
      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.admin.breadcrumb.new')

      render template: 'concerns/tabled/new'
    end
  end


  def table_columns
    %w(name created_at)
  end

  def init_form
  end

  def item_params
    params.require(:ind_category).permit(
      :name,
      :color,
      :description
    )
  end
end
