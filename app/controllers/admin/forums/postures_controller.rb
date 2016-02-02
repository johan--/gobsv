class Admin::Forums::PosturesController < Admin::ForumsController
  def model
    ::Forums::Posture
  end

  def table_columns
    %w(created_at theme_id organization_id actor_id quote)
  end

  def init_form
    @themes = ::Forums::Theme.order(:name)
    @organizations = ::Forums::Organization.order(:name)
    @actors = ::Forums::Actor.order(:name)
    @entries = ::Forums::Entry.order(:name)
  end

  def item_params
    params.require(:forums_posture).permit(
      :theme_id,
      :organization_id,
      :actor_id,
      :entry_id,
      :quote
    )
  end
end