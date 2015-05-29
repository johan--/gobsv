class AddImageToTaImages < ActiveRecord::Migration
  def change
    add_attachment :ta_images, :image
  end
end
