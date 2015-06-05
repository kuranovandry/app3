class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :date_of_birth, :email, :password, :encrypted_password)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:first_name, :last_name, :date_of_birth, :email, :password, :encrypted_password)}
  end
end
