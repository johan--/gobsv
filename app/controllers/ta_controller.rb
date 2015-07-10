class TaController < ApplicationController

  before_action :categories
  before_action :pages
  before_action :init_q

  def init_q
    @q = Ta::Article.ransack(params[:q])
  end

  def categories
    @categories = Ta::Category.order(:name)
  end

  def pages
    @pages = Ta::Page.order(:priority)
  end
end
