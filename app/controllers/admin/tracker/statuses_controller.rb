class Admin::Tracker::StatusesController < Admin::TrackerController

  def model
    ::Tracker::Status
  end

  def table_columns
    %w(status_id name)
  end

  def init_form
   @statuses = Tracker::Status.where(status_id: nil).order(:name).map{ |status| [status.name, status.id] }
  end

  def item_params
    params.require(:tracker_status).permit(
      :name,
      :status_id,
    )
  end

end
