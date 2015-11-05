class Complaints::UsersController < ComplaintsController
  def index
    @users = current_admin.children.order(:name)
  end

  def create
    admin.assign_attributes item_params
    if admin.save
      flash[:success] = 'Usuario creado con exito'
      redirect_to complaints_users_url and return
    else
      render :new
    end
  end

  def update
    admin.assign_attributes item_params
    if admin.save
      flash[:success] = 'Usuario actualizado con exito'
      redirect_to complaints_users_url and return
    else
      render :edit
    end
  end

  def destroy
    admin.destroy
    flash[:success] = 'Usuario eliminado con exito'
    redirect_to complaints_users_url and return
  end

  def admin
    @admin ||= params[:id] ? Admin.find(params[:id]) : current_admin.children.new
  end
  helper_method :admin

  def item_params
    params.require(:admin).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
