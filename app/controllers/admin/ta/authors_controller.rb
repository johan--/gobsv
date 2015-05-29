class Admin::Ta::AuthorsController < Admin::TaController

  def model
    ::Ta::Author
  end

  def table_columns
    %w(name twitter)
  end

  def init_form
    @admins = Admin.order :name
  end

  def item_params
    params.require(:ta_author).permit(
      :name,
      :twitter,
      :admin_id
    )
  end
end
