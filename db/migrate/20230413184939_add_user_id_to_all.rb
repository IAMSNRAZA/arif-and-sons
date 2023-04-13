class AddUserIdToAll < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :user_id, :integer
    add_column :products, :user_id, :integer
    add_column :orders, :user_id, :integer
    add_column :order_items, :user_id, :integer
    add_column :payment_transactions, :user_id, :integer

  end
end
