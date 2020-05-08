class Order < ApplicationRecord
    belongs_to :user
    has_many :shopping_carts

    def user_name
      user.username
    end

    def update_status(status)
      shopping_carts.each do |cart|
        if(cart.status != status)
          return nil
        end
      end
      self.status = status
      self.save
    end
    
    before_create :calculate_price
    after_create :submit_cart  

  private
    def calculate_price
      shopping_carts = ShoppingCart.current_cart(user.id)
      shopping_carts.each{|cart| self.price += cart.price }
    end

    def submit_cart
      ShoppingCart.submit_current_cart(user.id, self.id)
    end
end
