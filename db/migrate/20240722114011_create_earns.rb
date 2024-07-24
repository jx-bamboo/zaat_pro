class CreateEarns < ActiveRecord::Migration[7.1]
  def change
    create_table :earns do |t|
      t.string :chain
      t.string :txhash, index: true
      t.string :model_file
      t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
