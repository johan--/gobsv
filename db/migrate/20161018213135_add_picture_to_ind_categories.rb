class AddPictureToIndCategories < ActiveRecord::Migration
  def change
    add_attachment :ind_categories, :picture
  end
end
