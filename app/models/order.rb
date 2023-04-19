class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :payment_transactions
  has_many :products, through: :order_items
  accepts_nested_attributes_for :order_items, allow_destroy: true

  # before_create :deduct_stock
  after_create :add_remainings_for_customer
  after_create :create_transaction
  after_destroy :revert_stock
  after_destroy :remove_transaction

  def revert_stock
    self.order_items.each do |item|
      product = item.product
      quantity = item.quantity
      product.quantity += quantity
      product.save
    end
  end

  def deduct_stock
    self.order_items.each do |item|
      product = item.product
      quantity = item.quantity
      if product.quantity >= quantity
        product.quantity -= quantity
        product.save
      else
        self.errors.add(:base, "#{quantity} #{product.name} are not available in Stock")
        return false
      end
    end
    return true
  end

  def create_transaction
    transaction = PaymentTransaction.new(order_id: self.id, credit: self.payed_amount, notes: "#{self.id} Order Transaction", user_id: self.user_id)
    transaction.save
  end

  def remove_transaction
    transaction = PaymentTransaction.new(order_id: self.id, debit: self.payed_amount, notes: "#{self.id} Order Transaction", user_id: self.user_id)
    transaction.save
  end

  def add_remainings_for_customer
    if self.remaining_amount && self.remaining_amount > 0
      customer = self.customer
      customer.remaining_balance += self.remaining_amount.to_f
      customer.save
    end
  end

end
