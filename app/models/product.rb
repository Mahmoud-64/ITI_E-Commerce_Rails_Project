class Product < ApplicationRecord
    belongs_to :brand
    belongs_to :category
    has_many_attached :image

end
