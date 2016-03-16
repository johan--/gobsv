class Complaints::DocumentsController < ComplaintsController

  def index
    @q = ::Complaints::Asset.ransack(params[:q])
    @documents = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

end
