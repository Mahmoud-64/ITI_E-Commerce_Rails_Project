class OnlyAdminAuthorization < ActiveAdmin::AuthorizationAdapter

    def authorized?(action, subject = nil)
        user.admin? || user.seller?

    end

  end
