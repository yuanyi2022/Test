class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :user_uuid
      t.integer :ticket_id
      t.integer :stock
      t.timestamps
    end

    add_index :orders, [:user_id]
    add_index :orders, [:user_uuid]

  end
end
