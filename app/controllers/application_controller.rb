class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout

   protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :role
    devise_parameter_sanitizer.for(:account_update) << :role
	 end
	private

	def set_layout
		(user_signed_in? && current_user.admin?) ? "admin" : "application"
	end
end
