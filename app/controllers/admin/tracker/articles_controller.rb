class Admin::Tracker::ArticlesController < Admin::TrackerController

  def model
    ::Tracker::Article
  end

  def table_columns
      %w(name author_id publish_date status_id)
  end

  def init_form
   @authors = Tracker::Author.order(:name).map{ |author| [author.name, author.id] }
   @statuses = Tracker::Status.where.not('status_id' => nil).order("status_id ASC, name ASC").map{ |status| ["#{status.status.name} / #{status.name}", status.id] }

  end

  def item_params
    params.require(:tracker_article).permit(
      :name,
      :description,
      :author_id,
      :publish_date,
    )
  end

end
