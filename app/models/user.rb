class User < ApplicationRecord
  has_many :customers
  has_many :order_items
  has_many :orders
  has_many :payment_transactions
  has_many :products

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
