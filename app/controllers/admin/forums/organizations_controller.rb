class Admin::Forums::OrganizationsController < Admin::ForumsController
  def model
    ::Forums::Organization
  end

  def table_columns
    %w(created_at name)
  end

  def init_form
  end

  def item_params
    params.require(:forums_organization).permit(
      :name,
      :logo
    )
  end
end
