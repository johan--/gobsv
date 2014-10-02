class Admin::CnsEventsController < Admin::TabledController

  def model
    CnsEvent
  end

  def item_params
    params.require(:cns_event).permit(:name, :description, :event_date)
  end
end
