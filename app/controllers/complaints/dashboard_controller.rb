class Complaints::DashboardController < ComplaintsController
  def index
    @new = ::Complaints::Expedient.status('new').count
    @process = ::Complaints::Expedient.status('process').count
    @closed = ::Complaints::Expedient.status('closed').count
    @last_managements = ::Complaints::ExpedientManagement.closed.limit(4).order(updated_at: :desc)
    @new_managements = ::Complaints::ExpedientManagement.news.order(created_at: :asc).limit(5)
  end
end
