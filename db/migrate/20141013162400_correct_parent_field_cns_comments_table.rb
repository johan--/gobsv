class CorrectParentFieldCnsCommentsTable < ActiveRecord::Migration
  def change
    remove_column :cns_comments, :cns_proposals_id, :integer
    add_column :cns_comments, :cns_proposal_id, :integer, null: false
    add_index :cns_comments, :cns_proposal_id
  end
end
