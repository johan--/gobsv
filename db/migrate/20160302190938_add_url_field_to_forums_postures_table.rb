class AddUrlFieldToForumsPosturesTable < ActiveRecord::Migration
  def change
    add_column :forums_postures, :url, :string
  end
end
