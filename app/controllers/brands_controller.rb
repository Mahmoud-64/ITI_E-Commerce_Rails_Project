class BrandsController < ApplicationController
    # load_and_authorize_resource
    
    def index
        @brands = Brand.all
      end
    
      def show
          @brand = Brand.find(params[:id])
  
      end
    
      def new
        @brand = Brand.new
      end
    
      def edit
          @brand = Brand.find(params[:id])
      end
    
      def create
          @brand = Brand.new(brand_params)
          @brand.save
        
      end
    
  
      def update
          @brand = Brand.find(params[:id])
          if @brand.update(brand_params)
              redirect_to @brand
          else
              render 'edit'
          end
      end
  
    
      def destroy
          @brand = Brand.find(params[:id])
          @brand.destroy
      end
    
        def brand_params
          params.require(:brand).permit(:name)
        end
  
end
