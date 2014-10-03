class Admin::CnsArticlesController < Admin::TabledController

  def model
    CnsArticle
  end

  def item_params
    params.require(:cns_article).permit(:name, :description, :article_date, :picture)
  end
end
