class AddPriorityFieldToEmploymentsSpecialtiesTable < ActiveRecord::Migration
  def change
    add_column :employments_specialties, :priority, :integer, default: 0
  end
end
