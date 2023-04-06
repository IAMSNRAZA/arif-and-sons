class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.text :products
      t.decimal :total
      t.decimal :payed_amount
      t.decimal :remaining_amount

      t.timestamps
    end
  end
end
