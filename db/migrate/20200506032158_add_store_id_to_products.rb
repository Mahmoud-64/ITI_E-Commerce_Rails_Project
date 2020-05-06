class AddStoreIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :store, null: false, foreign_key: true
  end
end
