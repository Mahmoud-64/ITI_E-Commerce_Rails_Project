ActiveAdmin.register Store do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
    # seller = User.find(params[:user_id])
    # seller
    controller do
      def create
        # Good
        @store = Store.new(permitted_params[:store])
        if @store.save
          @seller = User.find(params[:store][:user_id])
          @seller.seller!
          redirect_to admin_stores_path
        end
      end
    end
end
