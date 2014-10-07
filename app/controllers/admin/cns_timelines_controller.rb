class Admin::CnsTimelinesController < Admin::TabledController

  def model
    CnsTimeline
  end

  def item_params
    params.require(:cns_timeline).permit(:name, :description, :timeline_date, :url)
  end
end
