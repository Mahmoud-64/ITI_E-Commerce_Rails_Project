class Order < ApplicationRecord
    belongs_to :user

    def user_name
        user.username
    end
end
