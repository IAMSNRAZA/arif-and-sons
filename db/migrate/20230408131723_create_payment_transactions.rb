class CreatePaymentTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_transactions do |t|
      t.float :credit
      t.float :debit
      t.text :notes
      t.string :transaction_type

      t.timestamps
    end
  end
end
