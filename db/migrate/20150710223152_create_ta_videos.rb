class CreateTaVideos < ActiveRecord::Migration
  def change
    create_table :ta_videos do |t|
      t.integer :priority
      t.references :article, index: true
      t.string :title
      t.text :description
      t.attachment :image
      t.string :url

      t.timestamps
    end
  end
end
