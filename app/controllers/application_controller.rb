class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :prepare_for_mobile#, :redirect_to_https
	before_filter :authenticate_admin!
	helper_method :mobile_device?

	private

	def mobile_device?
		if session[:mobile_param]
			session[:mobile_param] == "1"
		else
#			request.user_agent =~ /Mobile|webOS/
			false
		end
	end

	def prepare_for_mobile
		session[:mobile_param] = params[:mobile] if params[:mobile]
		request.format = :mobile if mobile_device?
	end

	def redirect_to_https
	    redirect_to :protocol => "https://" unless request.ssl?
	end

end
