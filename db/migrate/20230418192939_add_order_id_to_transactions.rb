class AddOrderIdToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_transactions, :order_id, :integer
  end
end
