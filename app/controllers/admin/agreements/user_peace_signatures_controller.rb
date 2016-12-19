class Admin::Agreements::UserPeaceSignaturesController < Admin::AgreementsController
  respond_to :html, :json

  def index
    @items = model.select(table_columns + [:id]).where(conditions).decorate
    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @items }
    end

  end

  def conditions(conditions = {})
    conditions
  end

  def model
    ::Agreements::UserPeaceSignature
  end

  def index_url
    url_for action: :index
  end

  def table_columns
    %w(name country state email phone created_at)
  end

end
