class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :in_stock_quantity

      t.references :brand, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
