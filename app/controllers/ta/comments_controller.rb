class Ta::CommentsController < TaController

  respond_to :json

  def create
    @article = ::Ta::Article.find params[:article_id]
    @comment = ::Ta::Comment.new comment_params
    @comment.article = @article

    if @comment.save
      respond_with @comment, status: :created, location: nil
    else
      respond_with nil, json: @comment.errors, status: :unprocessable_entity
    end
  end

  def comment_params
    params.require(:ta_comment).permit(
      :name,
      :email,
      :message
    )
  end
end
