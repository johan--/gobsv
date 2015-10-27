class ComplaintsController < ApplicationController
  before_action :authenticate_admin!
end
