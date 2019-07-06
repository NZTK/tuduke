class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_search

def set_search
	@search = Novel.ransack(params[:q])
	@search_novels = @search.result
end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
	end
end
