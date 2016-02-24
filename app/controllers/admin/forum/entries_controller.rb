class Admin::Forum::EntriesController < Admin::ForumController
  def model
    ::Forum::Entry
  end

  def table_columns
    %w(entry_at theme_id kind title)
  end

  def init_form
    @themes = ::Forum::Theme.order(:name)
    @organizations = ::Forum::Organization.order(:name)
    @actors = ::Forum::Actor.order(:name)
  end

  def item_params
    params.require(:forum_entry).permit(
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
