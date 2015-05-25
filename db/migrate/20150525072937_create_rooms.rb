class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string  :url,    null: false
      t.string  :number, null: false
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
