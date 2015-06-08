class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :room,     null: false
      t.references :user,     null: false
      t.integer :icon_number, null: false, default: 1
      t.string  :author,      null: false
      t.string  :body,        null: false

      t.timestamps null: false
    end

    add_foreign_key :comments, :rooms
    add_foreign_key :comments, :users
  end
end
