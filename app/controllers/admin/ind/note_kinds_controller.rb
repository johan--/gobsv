class Admin::Ind::NoteKindsController < Admin::IndController

  def model
    ::Ind::NoteKind
  end

  def create
    @item = model.new item_params
    #@item.admin = current_admin

    if @item.save
      redirect_to url_for(action: :index), notice: t('layouts.admin.notice.created')
    else

      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.admin.breadcrumb.new')

      render template: 'concerns/tabled/new'
    end
  end

  def edit
    @item = model.find params[:id]

    add_breadcrumb model.model_name.human(count: :many), index_url
    add_breadcrumb t('layouts.admin.breadcrumb.edit')

    render template: 'concerns/tabled/edit'
  end

  def table_columns
    %w(name created_at)
  end

  def item_params
    params.require(:ind_note_kind).permit(
      :name,
    )
  end
end
