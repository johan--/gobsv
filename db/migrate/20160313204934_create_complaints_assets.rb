class CreateComplaintsAssets < ActiveRecord::Migration
  def change
    create_table :complaints_assets do |t|
      t.references :admin, index: true
      t.attachment :asset
      t.string :name
      t.timestamps
    end
  end
end
