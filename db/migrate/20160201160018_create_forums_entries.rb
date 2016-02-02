class CreateForumsEntries < ActiveRecord::Migration
  def change
    create_table :forums_entries do |t|

      t.timestamps
    end
  end
end
