class AddLocationAndContractTypeFieldsToEmploymentsPublicCompetitionsTable < ActiveRecord::Migration
  def change
    add_column :employments_public_competitions, :location, :string
    add_column :employments_public_competitions, :contract_type, :string
  end
end
