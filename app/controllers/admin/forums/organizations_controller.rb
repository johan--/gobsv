class Admin::Forums::OrganizationsController < AdminController
  include Tabled

  def model
    ::Forums::Organization
  end

  def table_columns
    %w(created_at kind name)
  end

  def init_form
  end

  def item_params
    params.require(:forums_organization).permit(
      :name,
      :logo,
      :kind
    )
  end
end
