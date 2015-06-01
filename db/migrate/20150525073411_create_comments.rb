class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :room_id,     null: false
      t.integer :user_id,     null: false
      t.integer :icon_number, null: false, default: 1
      t.string  :author,      null: false
      t.string  :body,        null: false

      t.timestamps null: false
    end
  end
end
