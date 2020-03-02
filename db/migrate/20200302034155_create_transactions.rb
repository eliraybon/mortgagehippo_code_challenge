class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id, null: false 
      t.integer :coin_id, null: false 
      t.string :type, null: false 

      t.timestamps
    end
    add_index :transactions, :user_id
  end
end
