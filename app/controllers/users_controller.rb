class UsersController < ApplicationController
	before_action  :user_admin, only: [:index]
	def index
		@users = User.all
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	    User.find(params[:id]).destroy

	    redirect_to users_path
	end

	def like
	end

	def follow
	end

	def history
	end

end
private
def user_admin
	@users =  User.all
	if  current_user.admin  == false
		redirect_to root_path
	else
		render :index
	end
end


