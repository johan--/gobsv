class AddSlugFieldToCnsProposalsTable < ActiveRecord::Migration
  def change
    add_column :cns_proposals, :slug, :string
    add_index :cns_proposals, :slug
  end
end
