class CreateIndSnNoteImages < ActiveRecord::Migration
  def change
    create_table :ind_sn_note_images do |t|
      t.references :sn_note, index: true
      t.attachment :file
      t.timestamps null: false
    end
  end
end
