class Product < ApplicationRecord
    belongs_to :brand
    belongs_to :category
    has_one_attached :image
    belongs_to :store
    validate :image_type

    private
    def image_type
       if image.attached?
         if !image.content_type.in?(%('image/jpeg image/png image/jpg'))
           errors.add(:image, "needs to be a jpeg, jpg, png only!")
         end
       end
    end
end
