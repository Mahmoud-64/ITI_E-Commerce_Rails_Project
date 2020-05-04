class ProductsController < ApplicationController
    def index
    
        @products = Product.all
    end

    def show
        @product = Product.find(params[:id])

    end

    def new
    @product = Product.new
    end

    def edit
    end

    def create
        @product = Product.new(product_params)
        @product.save
    end

    def update
        @product = Brand.find(params[:id])
          if @product.update(product_params)
              redirect_to @product
          else
              render 'edit'
          end
    end

    def destroy
        @product.destroy
    end


    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :in_stock_quantity, :image, :brand_id, :category_id)
    end
end
