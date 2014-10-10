class CreateUserAuthorizations < ActiveRecord::Migration
  def change
    create_table :user_authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :username
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
