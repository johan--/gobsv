class Admin::Forums::ActorsController < Admin::ForumsController
  def model
    ::Forums::Actor
  end

  def table_columns
    %w(created_at name)
  end

  def init_form
  end

  def item_params
    params.require(:forums_actor).permit(
      :name
    )
  end
end