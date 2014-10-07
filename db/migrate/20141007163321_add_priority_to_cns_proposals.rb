class AddPriorityToCnsProposals < ActiveRecord::Migration
  def change
  	add_column :cns_proposals, :priority, :integer, null: false, default: 0
  end
end
