class Consulta::CnsArticlesController < ApplicationController
  layout 'consulta'

  def index 
    @articles = CnsArticle.all
  end

end
