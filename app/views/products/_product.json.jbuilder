json.extract! product, :id, :name, :quantity, :stock_type, :min_limit, :created_at, :updated_at
json.url product_url(product, format: :json)
