class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.string  :url,        null: false
      t.string  :platform,   null: false
      t.string  :player_url, null: false
      t.boolean :live,       null: false, default: false
      t.integer :room_id

      t.timestamps null: false
    end

    add_index :broadcasts, :room_id
  end
end
