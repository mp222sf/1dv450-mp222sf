class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      
      t.string :key
      t.string :appName
      t.string :appURL
      t.belongs_to :authentication, index: true
      t.timestamps null: false
    end
  end
end
