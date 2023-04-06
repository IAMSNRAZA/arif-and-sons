class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.string :stock_type
      t.integer :min_limit
      t.decimal :item_price

      t.timestamps
    end
  end
end
