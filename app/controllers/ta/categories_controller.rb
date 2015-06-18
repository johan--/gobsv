class Ta::CategoriesController < TaController

  def index
    @article  = Ta::Article.publish.newer.first
    @articles = Ta::Article.publish.newer.limit(3).offset(1)

    @gallery   = Ta::Article.publish.gallery.newer.first
    @galleries  = Ta::Article.publish.gallery.newer.limit(2).offset(1)

    @yesterday_articles = Ta::Article.yesterday.publish.newer.limit(3)

    @featured = Ta::Article.featured.newer.limit(5)
  end

  def show
    @category = Ta::Category.find params[:id]
    @articles = @category.articles.publish.newer.paginate(page: params[:page])

    add_breadcrumb 'Inicio', ta_root_url
    add_breadcrumb @category.name, nil
  end
end
