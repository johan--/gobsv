class Consulta::CnsArticlesController < ApplicationController
  layout 'consulta'

  def index 
    @articles = CnsArticle.all
  end

  private
    def article
      @article ||= params[:id] ? CnsArticle.find(params[:id]) : CnsArticle.new
    end
    helper_method :article

end
