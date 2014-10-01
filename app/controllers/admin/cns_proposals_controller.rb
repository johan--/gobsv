class Admin::CnsProposalsController < Admin::TabledController

  def model
    CnsProposal
  end

  def item_params
    params.require(:cns_proposal).permit(:cns_category_id, :name, :description)
  end

  def init_form
    @cns_categories = CnsCategory.all
  end
end
