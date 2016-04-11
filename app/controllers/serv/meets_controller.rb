class Serv::MeetsController < ServController
  ##
  # This controller respond
  # just to json
  respond_to :json

  def index
    @meets = ::Serv::Meet.where(room_id: params[:room_id])
    respond_with @meets, location: nil, status: :ok
  end

  def show
    @meet = ::Serv::Meet.find params[:id]
    respond_with @meet, location: nil, status: :ok
  end

  def new
    @meet = ::Serv::Meet.new
    respond_with @meet, location: nil, status: :ok
  end

  def create
    @meet = ::Serv::Meet.new(parameters)
    @meet.admin = current_admin
    if @meet.save
      render json: @meet, status: :created, location: nil
    else
      render json: @meet.errors, status: :unprocessable_entity
    end
  end

  def edit
    @meet = ::Serv::Meet.find params[:id]
  end

  def update
    @meet = ::Serv::Meet.find(params[:id])
    if @meet.update(parameters)
      head :no_content
    else
      render json: @meet.errors, status: :unprocessable_entity
    end
  end

  def booking
    @meet = ::Serv::Meet.booking(
      current_admin,
      params[:room_id],
      params[:year],
      params[:month],
      params[:day],
      params[:hour],
      params[:minute]
    )
    respond_with @meet, location: nil, status: :ok
  end

  def week
    @meets = ::Serv::Meet.week(
      params[:room_id],
      params[:year],
      params[:month],
      params[:day],
      params[:hour],
      params[:minute]
    )
    respond_with @meets, location: nil, status: :ok
  end

  def parameters
    params.require(:meet).permit(
      :room_id,
      :title,
      :audience_type,
      :assistants_number,
      :require_assistance,
      :observations,
      :start,
      :end
    )
  end
end
