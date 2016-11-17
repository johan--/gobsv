class AddReferenceCodeToComplaintsExpedientsTable < ActiveRecord::Migration
  def change
    add_column :complaints_expedients, :reference_code, :string, default: ''
  end
end
