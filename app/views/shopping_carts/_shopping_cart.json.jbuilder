json.extract! shopping_cart, :id, :user_id, :product_id, :quantity, :price, :order_id, :created_at, :updated_at
json.url shopping_cart_url(shopping_cart, format: :json)
