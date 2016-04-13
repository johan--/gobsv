class CreateServRooms < ActiveRecord::Migration
  def change
    create_table :serv_rooms do |t|
      t.string :name

      t.timestamps
    end
  end
end
