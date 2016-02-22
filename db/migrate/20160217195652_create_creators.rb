class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :firstName
      t.string :lastName
      t.timestamps null: false
    end
  end
end
