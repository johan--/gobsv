class CreateForumsActors < ActiveRecord::Migration
  def change
    create_table :forums_actors do |t|
      t.string :name
      t.timestamps
    end
  end
end
