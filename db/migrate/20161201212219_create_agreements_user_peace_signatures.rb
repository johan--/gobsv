class CreateAgreementsUserPeaceSignatures < ActiveRecord::Migration
  def change
    create_table :agreements_user_peace_signatures do |t|
      t.string :name
      t.string :place
      t.string :email
      t.string :phone
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
