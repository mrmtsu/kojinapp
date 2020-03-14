class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.integer :price, null: false
      t.timestamps
    end
    add_index :items, :name
    add_index :items, :image
    add_index :items, :price
  end
end
