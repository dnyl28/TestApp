class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permit the additional `name` and `user_type` fields during sign up and account update
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_type])
  end
end