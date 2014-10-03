class AddPictureToCnsEvent < ActiveRecord::Migration
  def up
    add_attachment :cns_events, :picture
  end

  def down
    add_attachment :cns_events, :picture
  end
end
