class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.belongs_to :pizzeria
      t.timestamps null: false
    end
  end
end
