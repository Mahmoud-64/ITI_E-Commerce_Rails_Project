ActiveAdmin.register Product do
  menu priority: 5
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :price, :in_stock_quantity, :brand_id, :category_id
  #
  # or
  #
  permit_params do
    permitted = [:title, :description, :price, :in_stock_quantity, :brand_id, :category_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

end
