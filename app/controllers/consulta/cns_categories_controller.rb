class Consulta::CnsCategoriesController < ApplicationController
  layout 'consulta'

  def index 
    @categories = CnsCategory.all
    show_breadcrumbs
  end

  def show
    @category = CnsCategory.find(params[:id])
    @proposals = CnsProposal.where("cns_category_id = ?", @category.id)
    show_breadcrumbs(@category)
  end

  private
    def show_breadcrumbs category=nil
      add_breadcrumb I18n.t('layouts.consulta.home'), root_path
      add_breadcrumb I18n.t('layouts.consulta.categories'), consulta_cns_categories_path
      add_breadcrumb @category.name, consulta_cns_category_path(category) unless category.nil?
    end
end
