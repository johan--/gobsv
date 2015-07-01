class AddDescriptionToTaImages < ActiveRecord::Migration
  def change
    add_column :ta_images, :description, :text
  end
end
