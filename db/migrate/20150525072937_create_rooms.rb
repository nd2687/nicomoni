class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string  :name,      null: false
      t.string  :url_token, null: false
      t.integer :number,    null: false
      t.integer :user_id,   null: false
      t.boolean :private,   null: false, default: false
      t.boolean :deletable, null: false, default: false

      t.timestamps null: false
    end
  end
end
