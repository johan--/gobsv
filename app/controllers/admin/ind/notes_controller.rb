class Admin::Ind::NotesController < Admin::IndController

  def model
    ::Ind::Note
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

  def edit
    @item = model.find params[:id]
    init_form
    init_sn_notes
    add_breadcrumb model.model_name.human(count: :many), index_url
    add_breadcrumb t('layouts.admin.breadcrumb.edit')

    render template: 'concerns/tabled/edit'
  end

  def table_columns
    %w(category_id title created_at)
  end

  def init_form
    @categories  = ::Ind::Category.order :name
  end

  def init_sn_notes
    @twitter_notes = ::Ind::SnNote.where(note_id: @item.id).order :description
  end

  def item_params
    params.require(:ind_note).permit(
      :category_id,
      :title,
      :content,
    )
  end
end
