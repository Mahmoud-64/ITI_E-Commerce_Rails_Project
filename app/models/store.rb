class Store < ApplicationRecord
  belongs_to :user
  has_many :products
    delegate :can?, :cannot?, to: :ability
    def ability
      @ability ||= Ability.new(self)
    end

end
