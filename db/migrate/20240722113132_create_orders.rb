class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :chain
      t.string :txhash, index: true
      t.decimal :amount
      t.string :method
      t.string :order_number, index: true
      t.text :prompt
      t.string :image
      t.string :model
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
