class Product < ApplicationRecord

  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    %w[id name stock_type quantity item_price min_limit user_id created_at updated_at]
  end

  def stock_types
    ['Retail', 'Wholesale']
  end
end
