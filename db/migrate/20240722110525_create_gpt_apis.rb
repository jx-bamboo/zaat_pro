class CreateGptApis < ActiveRecord::Migration[7.1]
  def change
    create_table :gpt_apis do |t|
      t.string :key
      t.string :url
      t.string :port

      t.timestamps
    end
  end
end
