class EmploymentsController < ApplicationController
  before_filter :prepare_search

  def prepare_search
    @q = Employments::Plaza.ransack(params[:q])
  end
end
