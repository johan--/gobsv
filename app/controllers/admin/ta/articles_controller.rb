class Admin::Ta::ArticlesController < Admin::TaController

  def model
    ::Ta::Article
  end

  def table_columns
    %w(title created_at)
  end

  def init_form
    @categories = Ta::Category.order :name
    @authors = Ta::Author.order :name

    if @item.new_record?
      @item.author_id = Ta::Author.where(admin_id: current_admin.id).first.try(:id)
    end
  end

  def item_params
    params.require(:ta_article).permit(
      :category_id,
      :front,
      :featured,
      :pretitle,
      :title,
      :summary,
      :content,
      :tag_list,
      :status,
      :published_at,
      :author_id,
      :image,
      :layout,
      :video_url,
      :audio_url,
      images_attributes: [:id, :image, :priority, :title, :description, :_destroy],
      videos_attributes: [:id, :image, :priority, :title, :description, :url, :_destroy],
      audios_attributes: [:id, :image, :priority, :title, :description, :url, :_destroy]
    )
  end
end
