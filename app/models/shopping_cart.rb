class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :order, optional: true

  def self.current_cart(user)
    ShoppingCart.where(order_id: nil, user_id: user)  
  end

  def self.submit_current_cart(user, order)
    carts = self.current_cart(user)    
    carts.update_all(order_id: order, status: "Pending")
    carts
  end

  def pinned?
    self.status == "Pending"
  end

  def order_confirmed?
    self.order.status == "Confirmed"
  end

  def confirmed?
    self.status == "Confirmed"
  end

  before_save :calculate_price 
  after_update :check_status

  private
    def calculate_price
      # abort " #{product.price} self.price osama"
      self.price = product.price * self.quantity
      # abort " #{self.price} self.price osama"
    end

    def check_status
      # abort (order.present?).inspect
      # abort order.update_status(self.status)
      if order.present?
        order.update_status(self.status)
      end
      
    end
end
