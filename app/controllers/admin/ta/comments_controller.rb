class Admin::Ta::CommentsController < Admin::TaController

  def model
    ::Ta::Comment
  end

  def table_columns
    %w(article_title name email status created_at)
  end

  def index
    @items = model
      .joins(:article)
      .select(:id, :name, :email, :status, :created_at)
      .select('SUBSTRING("ta_comments"."name",  0, 45) AS name')
      .select('(SUBSTRING("ta_articles"."title", 0, 45) || \'...\') AS article_title')
      .where(conditions).decorate

    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html { render template: 'concerns/tabled/index' }
      format.json { render json: @items }
    end
  end

  def item_params
    params.require(:ta_comment).permit(
      :message,
      :status
    )
  end
end
