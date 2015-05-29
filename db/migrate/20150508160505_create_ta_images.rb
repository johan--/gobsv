class CreateTaImages < ActiveRecord::Migration
  def change
    create_table :ta_images do |t|
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
