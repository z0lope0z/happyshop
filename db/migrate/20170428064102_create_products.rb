class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :sold_out
      t.string :category
      t.boolean :under_sale
      t.integer :price
      t.integer :sale_price

      t.timestamps null: false
    end
  end
end
