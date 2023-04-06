class Customer < ApplicationRecord
  has_many :orders

  def remaining_balance
    orders.sum(:remaining_amount)
  end
end
