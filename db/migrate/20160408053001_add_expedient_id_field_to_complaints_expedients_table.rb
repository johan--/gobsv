class AddExpedientIdFieldToComplaintsExpedientsTable < ActiveRecord::Migration
  def change
    add_column :complaints_expedients, :expedient_id, :integer
    add_index :complaints_expedients, :expedient_id
  end
end
