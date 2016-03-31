class Complaints::DocumentsController < ComplaintsController

  def index
    @q = ::Complaints::Asset.ransack(params[:q])
    @documents = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @document = ::Complaints::Asset.find(params[:id])
    @document.destroy
    redirect_to complaints_documents_url, notice: 'Archivo eliminado con éxito' and return
  end

end
