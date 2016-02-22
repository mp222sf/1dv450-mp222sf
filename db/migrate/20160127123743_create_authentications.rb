class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
    
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.integer :rights,
                :null => false,
                :default => 2
      t.timestamps null: false
    end
  end
end
