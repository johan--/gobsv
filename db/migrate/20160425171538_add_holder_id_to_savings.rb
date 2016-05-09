class AddHolderIdToSavings < ActiveRecord::Migration
  def change
    add_column :paa_savings, :holder_id, :integer
  end
end
