class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.string :url,        null: false
      t.string :platform,   null: false
      t.string :player_url, null: false

      t.timestamps null: false
    end
  end
end
