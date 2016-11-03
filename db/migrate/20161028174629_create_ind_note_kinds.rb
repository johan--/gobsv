class CreateIndNoteKinds < ActiveRecord::Migration
  def change
    create_table :ind_note_kinds do |t|
      t.string :name
      t.timestamps
    end
  end
end
