class AdminController < ApplicationController

  before_action :authenticate_admin!

  def user_for_paper_trail
    current_admin ? current_admin.id : nil
  end
end
