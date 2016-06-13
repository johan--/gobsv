class Admin::Ofcia::PayrollsController < Admin::OfciaController

  def model
    ::Ofcia::Payroll
  end

  def table_columns
    %w(periodo fecha_presentacion_planilla id_procesamiento)
  end

  def init_form
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
