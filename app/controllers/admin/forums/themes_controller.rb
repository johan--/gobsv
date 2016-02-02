class Admin::Forums::ThemesController < Admin::ForumsController

  def model
    ::Forums::Theme
  end

  def table_columns
    %w(main active priority name)
  end

  def init_form
  end

  def item_params
    params.require(:forums_theme).permit(
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
