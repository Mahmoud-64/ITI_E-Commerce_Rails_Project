class ShoppingCartsController < ApplicationController
  before_action :set_shopping_cart, only: [:show, :edit, :update, :destroy]

  # GET /shopping_carts
  # GET /shopping_carts.json
  def index
    if(current_user.buyer?)
      @shopping_carts = ShoppingCart.current_cart(current_user.id)
    else
      @shopping_carts = ShoppingCart.where.not(order_id: nil)
    end
  end

  # GET /shopping_carts/1
  # GET /shopping_carts/1.json
  def show
    redirect_to shopping_carts_path
  end

  # GET /shopping_carts/new
  def new
    @shopping_cart = ShoppingCart.new
  end

  # GET /shopping_carts/1/edit
  def edit
  end

  # POST /shopping_carts
  # POST /shopping_carts.json
  def create
    # abort shopping_cart_params.inspect
    @shopping_cart = ShoppingCart.new(shopping_cart_params.merge(user_id: current_user.id, order_id: nil))
    # abort @shopping_cart.inspect

    respond_to do |format|
      if @shopping_cart.save
        # abort @shopping_cart.inspect
        format.html { redirect_to @shopping_cart, notice: 'Shopping cart was successfully created.' }
        format.json { render :show, status: :created, location: @shopping_cart }
      else
        # abort @shopping_cart.inspect
        format.html { render :new }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shopping_carts/1
  # PATCH/PUT /shopping_carts/1.json
  def update
    # abort shopping_cart_params_update.inspect
    respond_to do |format|
      if @shopping_cart.update(shopping_cart_params_update)
        format.html { redirect_to @shopping_cart, notice: 'Shopping cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @shopping_cart }
      else
        format.html { render :edit }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_carts/1
  # DELETE /shopping_carts/1.json
  def destroy
    @shopping_cart.destroy
    respond_to do |format|
      format.html { redirect_to shopping_carts_url, notice: 'Shopping cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def confirm
    ShoppingCart.find(params[:id]).update(status: "Confirmed")
    redirect_to shopping_carts_path 
  end

  def delever
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopping_cart
      @shopping_cart = ShoppingCart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shopping_cart_params
      
      params.permit(:product_id, :quantity)
    end

    def shopping_cart_params_update   
      params.require(:shopping_cart).permit(:quantity)
    end
end
