class AddApplyCountersToEmploymentsPlazasTable < ActiveRecord::Migration
  def change
    add_column :employments_plazas, :stpp_apply_counter, :integer, default: 0
    add_column :employments_plazas, :spta_apply_counter, :integer, default: 0
  end
end
