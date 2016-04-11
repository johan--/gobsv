class Serv::RoomsController < ServController
  ##
  # This controller respond
  # just to json
  respond_to :json

  def index
    @rooms = ::Serv::Room.order :name
    respond_with @rooms, location: nil, status: :ok
  end

  def show
    @room = ::Serv::Room.find params[:id]
    respond_with @room, location: nil, status: :ok
  end
end
