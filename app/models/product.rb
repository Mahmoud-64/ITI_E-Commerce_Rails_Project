class Product < ApplicationRecord
    belongs_to :brand
    belongs_to :category
    has_one_attached :image

end
