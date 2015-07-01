class AddPriorityToTaImages < ActiveRecord::Migration
  def change
    add_column :ta_images, :priority, :integer, null: false, default: 0
  end
end
