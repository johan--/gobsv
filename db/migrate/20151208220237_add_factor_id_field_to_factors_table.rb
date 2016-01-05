class AddFactorIdFieldToFactorsTable < ActiveRecord::Migration
  def change
    add_column :employments_factors, :factor_id, :integer, index: true
  end
end
