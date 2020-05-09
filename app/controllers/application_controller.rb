class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery
  #
  # def access_denied(exception)
  #   redirect_to root_path, alert: exception.message
  # end

  protected

  def configure_permitted_parameters
    # handle signup
    added_attrs = [:username, :email, :password, :password_confirmation, :avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    # devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  
end
