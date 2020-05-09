class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :order, optional: true

  validate :check_available

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

  def self.seller_orders(user)
    # abort ShoppingCart.joins(:product).inspect 
    ShoppingCart.where.not(order_id: nil).where(product_id: user.products) 
  end

  before_save :calculate_price 
  after_update :check_status
  after_save :change_available_quantity_in_product 
  before_destroy :release_holding_quantity

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

    def available_quantity?
      available = product.in_stock_quantity
      quantity <= available
    end

    def check_available
      unless available_quantity?
        errors.add(:quantity, "sorry quantity no available ")
      end  
    end

    def release_holding_quantity
      product.change_available_quantity -(self.quantity)
    end

    def change_available_quantity_in_product
      new_number = self.quantity
      old_number = self.quantity_before_last_save
      unless old_number.nil?
        new_number -= old_number
      end
      product.change_available_quantity new_number
    end
end
