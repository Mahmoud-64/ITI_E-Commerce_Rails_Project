class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :products
  belongs_to :order

  def self.current_cart(user)
    ShoppingCart.where(order_id: nil, user_id: user)
    
  end
end
