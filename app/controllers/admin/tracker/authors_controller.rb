class Admin::Tracker::AuthorsController < Admin::TrackerController

  def model
    ::Tracker::Author
  end

  def table_columns
    %w(name email)
  end

  def init_form
  end

  def item_params
    params.require(:tracker_author).permit(
      :name,
      :email,
    )
  end

end
