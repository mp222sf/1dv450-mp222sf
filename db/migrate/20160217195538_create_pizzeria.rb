class CreatePizzeria < ActiveRecord::Migration
  def change
    create_table :pizzeria do |t|
      t.string :name
      t.belongs_to :position
      t.belongs_to :creator
      t.timestamps null: false
      
      # Has many Tags.
    end
  end
end
