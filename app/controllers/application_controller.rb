# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_if_blocked
  before_action :check_if_user_blocked

  protected

  def configure_permitted_parameters
    added_attrs = [:firstname, :lastname, :username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  private

  def check_if_user_blocked
    if user_signed_in? && current_user.blocked?
      sign_out current_user
      flash[:alert] = "Your account has been blocked. Please contact support."
      redirect_to root_path
    end
  end

  def check_if_blocked
    if SiteSetting.first.is_blocked && current_user&.role != 'super admin'
      render file: "#{Rails.root}/public/503.html", status: :service_unavailable
    end
  end
end
