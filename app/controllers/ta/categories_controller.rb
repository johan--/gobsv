class Ta::CategoriesController < TaController

  def index
    @article  = Ta::Article.publish.newer.first
    @articles = Ta::Article.publish.newer.limit(3).offset(1)

    @gallery   = Ta::Article.publish.gallery.newer.first
    @galleries  = Ta::Article.publish.gallery.newer.limit(2).offset(1)

    @yesterday_articles = Ta::Article.yesterday.publish.newer.limit(3)

    @featured = Ta::Article.featured.newer.limit(5)

    set_meta_tags ({
      title: 'Noticias sobre transparencia, acceso a la Información y anticorrupción en El Salvador',
      site: 'TRANSPARENCIA ACTIVA',
      description: 'Transparencia Activa es un periódico digital que divulga las acciones de transparencia desarrolladas, rendición de cuentas, acceso a la información y lucha',
      keywords: 'noticias el salvador, trasparencia el salvador, transparencia activa, gobierno de el salvador, informacion el salvador, presidente funes,  informacion publica el salvador, noticias de verdad, gobierno del cambio',
      canonical: ta_root_url,
      author: 'Transparencia Activa',
      og: {
        title: 'Noticias sobre transparencia, acceso a la Información y anticorrupción en El Salvador',
        image: URI.join(request.url, 'assets/ta/missing.jpg'),
        description: 'Transparencia Activa es un periódico digital que divulga las acciones de transparencia desarrolladas, rendición de cuentas, acceso a la información y lucha',
        url: ta_root_url
      }
    })
  end

  def show
    @category = Ta::Category.find params[:id]
    @articles = @category.articles.publish.newer.paginate(page: params[:page])

    add_breadcrumb 'Inicio', ta_root_url
    add_breadcrumb @category.name, nil
  end
end
