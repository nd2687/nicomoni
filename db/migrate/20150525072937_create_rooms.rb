class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string  :name,          null: false
      t.string  :url_token,     null: false
      t.integer :number,        null: false
      t.integer :owner_id,      null: false
      t.boolean :private,       null: false, default: false
      t.boolean :deletable,     null: false, default: false
      t.integer :active_number, null: false, default: 0
      t.boolean :full,          null: false, default: false

      t.timestamps null: false
    end
  end
end
