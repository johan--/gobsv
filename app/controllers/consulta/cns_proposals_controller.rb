class Consulta::CnsProposalsController < ApplicationController
  layout 'consulta'

  def index 
    @proposals = CnsProposal.all
  end

  def show
    @proposal = CnsProposal.find(params[:id])
  end

end
