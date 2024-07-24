class CreateInvitedUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :invited_users do |t|
      t.integer :my_user_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
