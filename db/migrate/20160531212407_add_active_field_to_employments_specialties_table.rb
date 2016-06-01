class AddActiveFieldToEmploymentsSpecialtiesTable < ActiveRecord::Migration
  def change
    add_column :employments_specialties, :active, :bool, default: :true
  end
end
