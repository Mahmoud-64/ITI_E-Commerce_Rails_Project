class Product < ApplicationRecord
    belongs_to :brand
    belongs_to :category
    has_one_attached :image
    belongs_to :store
end
