class AddImageDimensionsToTaImages < ActiveRecord::Migration
  def change
    add_column :ta_images, :image_width, :integer, null: false, default: 0
    add_column :ta_images, :image_height, :integer, null: false, default: 0
  end
end
