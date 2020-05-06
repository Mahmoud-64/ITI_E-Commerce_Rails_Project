class ProductsController < ApplicationController
    def index
        if params[:search].blank?
            @products = Product.all
        else
            # @products = Product.all.where("lower(title) LIKE :search", search: params[:search])
            @products = Product.all.where('title LIKE :search OR description LIKE :search', search: "%#{params[:search]}%")

        end
    end

    def show
        @product = Product.find(params[:id])

    end

    def new
    @product = Product.new
    @store = current_user.store()
    end

    def edit
        @product = Product.find(params[:id])
    end

    def create
        @product = Product.new(product_params)
        @product.store = current_user.store()
        @product.save
    end

    def update
        @product = Product.find(params[:id])
          if @product.update(product_params)
              redirect_to @product
          else
              render 'edit'
          end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to products_path
    end


    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :in_stock_quantity, :image, :brand_id, :category_id)
    end
end
