class Admin::Forum::OrganizationsController < Admin::ForumController
  def model
    ::Forum::Organization
  end

  def table_columns
    %w(created_at kind name)
  end

  def init_form
  end

  def item_params
    params.require(:forum_organization).permit(
      :name,
      :logo,
      :kind
    )
  end
end
