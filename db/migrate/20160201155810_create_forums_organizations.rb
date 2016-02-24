class CreateForumsOrganizations < ActiveRecord::Migration
  def change
    create_table :forums_organizations do |t|
      t.string :name
      t.attachment :logo
      t.timestamps
    end
  end
end
