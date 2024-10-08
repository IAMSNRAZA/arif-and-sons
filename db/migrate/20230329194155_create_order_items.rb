class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :product, null: false, foreign_key: true
      t.float :quantity
      t.float :price
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
