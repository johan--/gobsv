class Consulta::CnsProposalsController < ApplicationController
  layout 'consulta'

  def index 
    @category = CnsCategory.find(params[:cns_category_id])
    @proposals = CnsProposal.all
    show_breadcrumbs(@category)
  end

  def show
    @category = CnsCategory.find(params[:cns_category_id])
    @proposal = CnsProposal.find(params[:id])
    show_breadcrumbs(@category, @proposal)
  end

  private
    def show_breadcrumbs(category=nil, proposal=nil)
      add_breadcrumb I18n.t('layouts.consulta.home'), root_path
      add_breadcrumb I18n.t('layouts.consulta.categories'), consulta_cns_categories_path
      add_breadcrumb @category.name, consulta_cns_category_path(category) unless category.nil?
      add_breadcrumb @proposal.name, consulta_cns_category_cns_proposal_path(category, proposal) unless category.nil? or proposal.nil?
    end

end
