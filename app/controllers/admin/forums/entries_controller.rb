class Admin::Forums::EntriesController < Admin::ForumsController
  def model
    ::Forums::Entry
  end

  def table_columns
    %w(entry_at theme_id kind title)
  end

  def init_form
    @themes = ::Forums::Theme.order(:name)
    @organizations = ::Forums::Organization.order(:name)
    @actors = ::Forums::Actor.order(:name)
  end

  def item_params
    params.require(:forums_entry).permit(
      :kind,
      :theme_id,
      :organization_id,
      :actor_id,
      :title,
      :description,
      :url,
      :entry_at,
      :asset
    )
  end
end
