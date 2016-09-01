class GovermentServices::WelcomeController < GovermentServicesController
  def index
    @q = Ta::Article.search(params[:q])
    respond_to do |format|
      format.html
      format.js
    end
  end

end