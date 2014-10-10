class User::DashboardController < UserController
  def index
    render text: 'user#dashboard'
  end
end
