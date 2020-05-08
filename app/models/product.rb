class Product < ApplicationRecord
    belongs_to :brand
    belongs_to :category
    has_one_attached :image
    belongs_to :store

    def change_available_quantity(number)
        # abort number.inspect
        self.in_stock_quantity = self.in_stock_quantity - number
        # abort self.inspect
        self.save
    end
end
