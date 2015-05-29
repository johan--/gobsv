class TaController < ApplicationController

  before_action :categories

  def categories
    @categories = Ta::Category.all
  end
end
