class CreateTaAudios < ActiveRecord::Migration
  def change
    create_table :ta_audios do |t|
      t.integer :priority
      t.references :article, index: true
      t.string :title
      t.text :description
      t.string :url
      t.attachment :image

      t.timestamps
    end
  end
end
