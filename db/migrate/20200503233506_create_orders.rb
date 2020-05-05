class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.string :status
      t.integer :price

      t.timestamps
    end
  end
end
