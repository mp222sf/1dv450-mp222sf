class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :ingredients
      t.integer :price
      t.belongs_to :menu
      t.timestamps null: false
    end
  end
end
