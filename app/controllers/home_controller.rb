class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @products=Product.all()
    @categories=Category.all()
    @shoppingCarts=ShoppingCart.where(user_id: current_user)
    # byebug
  end
end
