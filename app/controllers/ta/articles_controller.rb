class Ta::ArticlesController < TaController

  def index
    @article  = Ta::Article.publish.newer.first
    @articles = Ta::Article.publish.newer.limit(3).offset(1)

    @gallery   = Ta::Article.publish.gallery.newer.first
    @galleries  = Ta::Article.publish.gallery.newer.limit(4).offset(1)

    @yesterday_articles = Ta::Article.yesterday.publish.newer.limit(3)

    @featured = Ta::Article.featured.newer.limit(5)
  end

  def show
    @article = Ta::Article.find params[:id]
    @comment = Ta::Comment.new
    @comments = @article.comments.where(status: Ta::Comment.statuses[:publish]).order(:created_at)

    set_meta_tags ({
      title: @article.title,
      site: 'Transparencia Activa',
      description: @article.summary,
      keywords: @article.tag_list,
      canonical: ta_article_url(@article),
      reverse: true,
      author: @article.author.try(:name),
      og: {
        title: @article.title,
        image: URI.join(request.url, @article.image.url(:medium)),
        description: @article.summary,
        url: ta_article_url(@article)
      }
    })


    add_breadcrumb 'Inicio', ta_root_url
    add_breadcrumb 'Noticia número uno', nil
  end
end
