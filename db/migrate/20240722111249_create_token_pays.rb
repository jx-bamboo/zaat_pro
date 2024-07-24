class CreateTokenPays < ActiveRecord::Migration[7.1]
  def change
    create_table :token_pays do |t|
      t.string :chain
      t.string :name
      t.string :symbol
      t.string :contract_address
      t.text :contract_abi
      t.string :receive_address
      t.decimal :price
      t.string :icon

      t.timestamps
    end
  end
end
