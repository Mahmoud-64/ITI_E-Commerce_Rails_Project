json.extract! order, :id, :user , :status, :price, :created_at, :updated_at
json.url order_url(order, format: :json)
