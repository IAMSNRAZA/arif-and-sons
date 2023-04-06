class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  accepts_nested_attributes_for :order_items, allow_destroy: true

  before_create :deduct_stock

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
end
