class Consulta::CnsProposalsController < ConsultaController

  respond_to :html, :js

  def index 
    @proposals = CnsProposal.all
    show_breadcrumbs(category)
  end

  def show
    respond_to do |format|
      format.html { show_breadcrumbs(category, proposal) }
      format.js
    end
  end

  private
    def show_breadcrumbs(category=nil, proposal=nil)
      add_breadcrumb I18n.t('layouts.consulta.home'), root_path
      add_breadcrumb I18n.t('layouts.consulta.categories'), consulta_cns_categories_path
      add_breadcrumb @category.name, consulta_cns_category_path(category) unless category.nil?
      add_breadcrumb @proposal.name, consulta_cns_category_cns_proposal_path(category, proposal) unless category.nil? or proposal.nil?
    end

    def proposal
      @proposal ||= params[:id] ? CnsProposal.find(params[:id]) : CnsProposal.new
    end
    helper_method :proposal

    def category
      @category ||= CnsCategory.find(params[:cns_category_id])
    end
    helper_method :category

    def comments
      @comments ||= CnsComment.where(cns_proposal_id: proposal.id).where('cns_comments.created_at < ?', params[:timestamp] ? Time.at(params[:timestamp].to_i) : Time.current).limit(5)
    end
    helper_method :comments

end
