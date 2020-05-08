class AddStoreIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :store, null: true, foreign_key: true
  end
end
