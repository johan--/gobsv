class UserController < ApplicationController
  before_action :authenticate_user!
  before_filter :prepare_search

  layout 'user/login'

  def prepare_search
    @q = Employments::Plaza.ransack(params[:q])
  end

end
