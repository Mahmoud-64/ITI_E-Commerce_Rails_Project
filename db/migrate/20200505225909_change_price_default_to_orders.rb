class ChangePriceDefaultToOrders < ActiveRecord::Migration[6.0]
  change_column_default :orders, :price, from: nil, to: 0  
end
