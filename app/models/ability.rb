# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # can :read, :all # permissions for every user, even if not logged in
    user ||= User.new
    if user.present?
      if user.admin?
        #handle admin ability
        can :manage, :all
      elsif user.seller?
        #handle seller ability
        can [:update], User, id: user.id
        can [:update, :read], Store, user_id: user.id

        can :create, Product
        can [:update, :read], Product, store_id: user.store
        can :read, ActiveAdmin::Page, name: "Dashboard"

        

        # can :manage, Product, store_id: {store: {user_id: user.id}}
        # can :manage, Order

        can :create, [ShoppingCart, Order]
        can [:destroy, :update], ShoppingCart, user_id: user.store.id
      elsif user.buyer?

        #handle buyer ability
        # can :read, Brand
        # can :read, Category
        # can :read, Product
        # can :manage, Cart
        # can [:create, :read], Order
      # else
        # can :read, Product

        can :create, [ShoppingCart, Order]
        can [:destroy, :update], ShoppingCart, user_id: user.id
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    #buyer:0
    #seller:1
  end
end
