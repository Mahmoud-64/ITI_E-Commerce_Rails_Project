ActiveAdmin.register Product do
  menu priority: 5
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :title, :description, :price, :in_stock_quantity, :image, :brand_id, :category_id, :store_id
  #
  # or
  #
  # permit_params do
    # permitted = [:title, :description, :price, :in_stock_quantity, :image, :brand_id, :category_id, :store_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  show do
    attributes_table do
      row :title
      row :description
      row  "Images" do |p|
        image_tag(p.image, :size=>"130x130",:class =>"thumbnail") if p.image.attached?
      end
      row :price
      row :in_stock_quantity
      row :brand
      row :category
      row :store
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :price
    column :in_stock_quantity
    column  "Images" do |p|
        image_tag(p.image, :size=>"50x50",:class =>"thumbnail") if p.image.attached?
    end
    column :brand_id
    column :category_id
    column :store_id
    actions
  end

  form title: 'A custom title' do |f|
     inputs 'Details' do
       input :title
       input :brand_id, as: :select, collection: Brand.all.collect{ |u| [u.name, u.id] }
       input :category_id, as: :select, collection: Category.all.collect{ |u| [u.name, u.id] }
       if current_user.admin?
         input :store_id, as: :select, collection: Store.all.collect{ |u| [u.name, u.id] }
       elsif current_user.seller?
         input :store_id, :as => :string, :input_html => { :value => current_user.store.id, :readonly => true, :hidden => true }
         strong current_user.store.name
       end
       input :description
       f.inputs "Attachment", :multipart => true do
          f.input :image, :as => :file
        end
       input :price
       input :in_stock_quantity
     end
     actions
   end


end
