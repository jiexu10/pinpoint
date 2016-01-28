class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :find_cart, if: user_signed_in?

  def find_cart
    @cart = current_user.cart
  end
  
  protected

  def after_sign_in_path_for(resource)
    resource.is_a?(User) ? root_path : restaurant_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) <<
      [:first_name, :last_name, :company_name]
  end
end
