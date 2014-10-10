class Consulta::CnsArticlesController < ConsultaController
  def index 
    @articles = CnsArticle.order("created_at DESC")
    show_breadcrumbs
  end

  def show
    show_breadcrumbs(article)
  end

  private
    def article
      @article ||= params[:id] ? CnsArticle.find(params[:id]) : CnsArticle.new
    end
    helper_method :article

    def show_breadcrumbs(article=nil)
      add_breadcrumb I18n.t('layouts.consulta.home'), root_path
      add_breadcrumb I18n.t('layouts.consulta.articles'), consulta_cns_articles_path
      add_breadcrumb article.name, consulta_cns_article_path(article) unless article.nil?
    end

end
