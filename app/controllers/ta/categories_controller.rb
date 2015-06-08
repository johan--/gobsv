class Ta::CategoriesController < TaController

  def show
    @category = Ta::Category.find params[:id]
    @articles = @category.articles.where(status: Ta::Article.statuses[:publish]).order(published_at: :desc).paginate(page: params[:page])
  end
end
