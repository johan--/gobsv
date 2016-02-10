class Admin::Forum::ThemesController < Admin::ForumController
  def model
    ::Forum::Theme
  end

  def table_columns
    %w(main active priority name)
  end

  def init_form
  end

  def item_params
    params.require(:forum_theme).permit(
      :name,
      :description,
      :actors_description,
      :citizens_description,
      :historical_description,
      :active,
      :main,
      :video_url,
      :cover,
      :twitter_id
    )
  end
end
