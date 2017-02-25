class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :sale_price
      t.boolean :under_sale
      t.boolean :sold_out

      t.timestamps
    end
  end
end
