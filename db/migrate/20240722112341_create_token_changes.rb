class CreateTokenChanges < ActiveRecord::Migration[7.1]
  def change
    create_table :token_changes do |t|
      t.decimal :amount, null: false
      t.string :event, null: false
      t.references :token, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
