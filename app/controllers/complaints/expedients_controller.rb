class Complaints::ExpedientsController < ComplaintsController

  def expedient
    @expedient ||= params[:id] ? Complaints::Expedient.find(params[:id]) : Complaints::Expedient.new
  end
  helper_method :expedient

  def item_params
    params.require(:complaints_expedient).permit(
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
