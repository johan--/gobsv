class Ta::ArticlesController < TaController

  def index
    @article  = Ta::Article.order(created_at: :desc).first
    @articles = Ta::Article.order(created_at: :desc).limit(2).limit(3)
  end

  def show
    @article = Ta::Article.find params[:id]
    @comment = Ta::Comment.new

    add_breadcrumb 'Inicio', ta_root_url
    add_breadcrumb 'Noticia número uno', nil
  end
end
