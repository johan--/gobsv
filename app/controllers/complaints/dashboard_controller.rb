class Complaints::DashboardController < ComplaintsController
  def index
    @process = ::Complaints::Expedient.status('process').count
    @closed = ::Complaints::Expedient.status('closed').count
    @last_managements = ::Complaints::ExpedientManagement.closed.limit(4).order(updated_at: :desc)
    @new_expedients = ::Complaints::Expedient.status('new')
  end
end
