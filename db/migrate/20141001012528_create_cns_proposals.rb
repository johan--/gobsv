class CreateCnsProposals < ActiveRecord::Migration
  def change
    create_table :cns_proposals do |t|
      t.references :cns_category, index: true
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
