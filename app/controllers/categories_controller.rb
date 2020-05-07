class CategoriesController < ApplicationController
    # load_and_authorize_resource
    
    def index
        
      @categories = Category.all
    #   authorize! :manage, @categories

    end
  
    def show
        @category = Category.find(params[:id])
        

    end
  
    def new
      @category = Category.new
      authorize! :manage, @category
    end
  
    def edit
        @category = Category.find(params[:id])
        authorize! :manage, @category
    end
  
    def create
        @category = Category.new(category_params)
        @category.save
      
    end
  

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            redirect_to @category
        else
            render 'edit'
        end
    end

  
    def destroy
        @category = Category.find(params[:id])
        authorize! :manage, @category
        @category.destroy
    end
  
      def category_params
        params.require(:category).permit(:name)
      end
end
