class GovermentServicesController < ApplicationController
  before_action :categories
  before_action :pages
  
  def categories
    @categories = Ta::Category.order(:name)
  end

  def pages
    @pages = Ta::Page.order(:priority)
  end
end
