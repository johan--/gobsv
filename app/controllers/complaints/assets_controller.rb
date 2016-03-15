class Complaints::AssetsController < ComplaintsController
  respond_to :html, :js

  def index
    if params[:q]
      @q = ::Complaints::Asset.ransack(params[:q])
      @assets = @q.result(distinct: true).paginate(page: params[:page], per_page: 5)
    end
  end

  def create
    @asset = ::Complaints::Asset.new(item_params)
    if @asset.valid?
      @asset.admin_id = current_admin.id
      @asset.save
    end
  end


  def item_params
    params.require(:complaints_asset).permit(
      :asset
    )
  end
end
