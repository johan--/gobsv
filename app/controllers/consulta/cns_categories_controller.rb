class Consulta::CnsCategoriesController < ApplicationController
  layout 'consulta'

  def index 
    @categories = CnsCategory.all
  end

  def show
    @category = CnsCategory.find(params[:id])
    @proposals = CnsProposal.where("cns_category_id = ?", @category.id)
  end

end
