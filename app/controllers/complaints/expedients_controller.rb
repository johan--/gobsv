class Complaints::ExpedientsController < ComplaintsController

  def index
    @expedients = Complaints::Expedient.newer.status(params[:state]).paginate(page: params[:page])
  end

  def create
    expedient.assign_attributes item_params
    expedient.admin_id = current_admin.id
    expedient.confirmed_at = Time.current
    expedient.admitted_at = Time.current
    if expedient.valid?
      expedient.set_correlative
      expedient.save
      redirect_to complaints_expedients_url(state: 'new') and return
    else
      render :new
    end
  end

  def expedient
    @expedient ||= params[:id] ? Complaints::Expedient.find(params[:id]) : Complaints::Expedient.new
  end
  helper_method :expedient

  def item_params
    params.require(:complaints_expedient).permit(
      :received_at,
      :kind,
      :contact,
      :phone,
      :email,
      :comment,
      :institution_id
    )
  end
end
