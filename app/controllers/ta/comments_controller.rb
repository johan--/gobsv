class Ta::CommentsController < TaController

  def create
    @article = Ta::Article.find params[:article_id]
    @comment = @article.comments.new comment_params

    if @comment.save
      redirect_to ta_article_url(@article), notice: t('layouts.admin.notice.created')
    else
      render
    end
  end
end
