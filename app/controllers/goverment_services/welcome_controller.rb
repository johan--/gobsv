require 'net/http'
class GovermentServices::WelcomeController < GovermentServicesController
  skip_before_action :verify_authenticity_token

  def index

    @q = Ta::Article.search(params[:q])
    @test = 
    respond_to do |format|
      format.html
      format.js
    end
  end

end