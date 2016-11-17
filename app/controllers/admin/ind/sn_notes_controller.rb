class Admin::Ind::SnNotesController < Admin::IndController
  before_filter :get_note

  def model
    ::Ind::SnNote
  end

  def new
    @item = model.new
    add_breadcrumb ::Ind::Note.model_name.human(count: :many), admin_ind_notes_url
    add_breadcrumb @note.title, edit_admin_ind_note_url(@note)
    add_breadcrumb t('layouts.admin.breadcrumb.new')
  end

  def create
    @item = model.new item_params
    #@item.admin = current_admin

    if @item.save
      redirect_to edit_admin_ind_note_url(@note), notice: t('layouts.admin.notice.created')
    else
      init_form
      add_breadcrumb ::Ind::Note.model_name.human(count: :many), admin_ind_notes_url
      add_breadcrumb @note.title, edit_admin_ind_note_url(@note)
      add_breadcrumb t('layouts.admin.breadcrumb.new')
    end
  end

  def edit
    @item = model.find params[:id]
    add_breadcrumb ::Ind::Note.model_name.human(count: :many), admin_ind_notes_url
    add_breadcrumb @note.title, edit_admin_ind_note_url(@note)
    add_breadcrumb t('layouts.admin.breadcrumb.edit')

  end

  def update
    @item = model.find params[:id]
    if @item.update_attributes item_params
      redirect_to url_for(action: :edit, id: @item.id), notice: t('layouts.admin.notice.updated')
    else
      add_breadcrumb ::Ind::Note.model_name.human(count: :many), admin_ind_notes_url
      add_breadcrumb @note.title, edit_admin_ind_note_url(@note)
      add_breadcrumb model.model_name.human(count: :many), index_url
      add_breadcrumb t('layouts.admin.breadcrumb.edit')
    end
  end

  def get_note
    @note = ::Ind::Note.find(params[:note_id])
  end
  helper_method :note

  def item_params
    params.require(:ind_sn_note).permit(
      :note_id,
      :description,
      :day,
      :hour,
      :minute,
      :active,
      sn_note_images_attributes: [:id, :file, :_destroy],
    )
  end
end
