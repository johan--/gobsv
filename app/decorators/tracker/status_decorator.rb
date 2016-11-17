class Tracker::StatusDecorator < Draper::Decorator
  delegate_all

  def status_id
    unless object.status.nil?
      object.status.name
    end
  end

end
