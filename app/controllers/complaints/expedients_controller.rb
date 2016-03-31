class Complaints::ExpedientsController < ComplaintsController

  def index
    @expedients = @search.result(distinct: true).paginate(page: params[:page], per_page: 5)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: expedient.correlative.present? ? "#{expedient.correlative}.pdf" : "nuevo_caso.pdf", encoding: "UTF-8"
      end
    end
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

  def redirect

  end

  def expedient
    @expedient ||= params[:id] ? Complaints::Expedient.find(params[:id]) : Complaints::Expedient.new
  end
  helper_method :expedient

  def managements
    @managements ||= expedient.managements.newer
  end
  helper_method :managements

  def item_params
    params.require(:complaints_expedient).permit(
      :received_at,
      :kind,
      :contact,
      :phone,
      :email,
      :comment,
      :institution_id,
      :asset
    )
  end
end
