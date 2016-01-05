class ChangeEmploymentsAreaNameFieldToText < ActiveRecord::Migration
  def up
    change_column :employments_areas, :name, :text
  end
  def down
    change_column :employments_areas, :name, :string
  end
end
