class Admin::Forum::ActorsController < Admin::ForumController
  def model
    ::Forum::Actor
  end

  def table_columns
    %w(created_at name)
  end

  def init_form
  end

  def item_params
    params.require(:forum_actor).permit(
      :name
    )
  end
end
