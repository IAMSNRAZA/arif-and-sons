json.extract! order, :id, :customer_id, :products, :total, :payed_amount, :remaining_amount, :created_at, :updated_at
json.url order_url(order, format: :json)
