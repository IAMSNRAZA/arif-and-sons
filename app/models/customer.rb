class Customer < ApplicationRecord
  has_many :orders
  belongs_to :user

  def remaining_balance
    orders.sum(:remaining_amount)
  end
end
