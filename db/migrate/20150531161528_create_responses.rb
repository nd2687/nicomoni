class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :board, null: false
      t.string  :name,     null: false
      t.string  :comment,  null: false

      t.timestamps null: false
    end

    add_index :responses, :board_id
  end
end
