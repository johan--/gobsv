class AddActiveFieldToPublicCompetitionsTable < ActiveRecord::Migration
  def change
    add_column :employments_public_competitions, :active, :boolean, default: true
  end
end
