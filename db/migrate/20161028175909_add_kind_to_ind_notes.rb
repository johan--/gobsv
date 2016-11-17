class AddKindToIndNotes < ActiveRecord::Migration
  def change
    add_column :ind_notes, :note_kind_id, :integer

  end
end
