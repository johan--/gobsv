class IndicatorsController < ApplicationController
  before_action :categories
  before_action :pages
  
  def categories
    @indicator_categories = ::Ind::Category.order :name
  end

  def pages
    @pages = Ta::Page.order(:priority)
  end
end
