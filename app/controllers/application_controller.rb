class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, :checked_login
	

  private
		def checked_login
			sign_out :user if admin_signed_in?
			sign_out :admin if user_signed_in?
		end
end
