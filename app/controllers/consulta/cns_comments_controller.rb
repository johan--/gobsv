class Consulta::CnsCommentsController < ConsultaController
  respond_to :js

  def create
    @comment = CnsComment.new item_params
    @comment.cns_proposal_id = proposal.try(:id)
    @comment.save
  end


  def item_params
    params.require(:cns_comment).permit(:name, :email, :content)
  end

  private
    def proposal
      @proposal ||= CnsProposal.find(params[:cns_proposal_id])
    end
    helper_method :proposal
end
