class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @products=Product.all()
    @categories=Category.all()
  end
end
