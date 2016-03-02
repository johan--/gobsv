class Admin::Forum::PosturesController < Admin::ForumController
  def model
    ::Forum::Posture
  end

  def table_columns
    %w(quoted_at theme_id organization_id actor_id quote)
  end

  def init_form
    @themes = ::Forum::Theme.order(:name)
    @organizations = ::Forum::Organization.order(:name)
    @actors = ::Forum::Actor.order(:name)
    @entries = ::Forum::Entry.order(:title)
  end

  def item_params
    params.require(:forum_posture).permit(
      :theme_id,
      :organization_id,
      :actor_id,
      :url,
      :quote,
      :quoted_at
    )
  end
end
