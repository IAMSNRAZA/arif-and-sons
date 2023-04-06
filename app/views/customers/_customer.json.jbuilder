json.extract! customer, :id, :name, :number, :remaining_balance, :created_at, :updated_at
json.url customer_url(customer, format: :json)
