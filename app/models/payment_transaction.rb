class PaymentTransaction < ApplicationRecord

  before_create :set_transaction_type

  def set_transaction_type
    if !credit || credit == 0
      self.transaction_type = 'debit'
    else
      self.transaction_type = 'credit'
    end
  end

  def self.total_credit
    all.where(transaction_type: 'credit').sum(:credit)
  end

  def self.total_debit
    all.where(transaction_type: 'debit').sum(:debit)
  end
end
