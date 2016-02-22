class CreatePizzeriaTags < ActiveRecord::Migration
  def change
    create_table :pizzeria_tags, id: false do |t|

      t.belongs_to :pizzeria, index: true, primary: true
      t.belongs_to :tag, index: true, primary: true
      t.timestamps null: false
    end
  end
end
