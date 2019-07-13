class UsersController < ApplicationController
	before_action  :user_admin, only: [:index]
	before_action :correct_user, only: [:edit]
	def index
		@users = User.page(params[:page])
	end

	def show
		@user = User.find(params[:id])
		@novels = Novel.where(user_id: @user.id)
		@novel_contents = NovelContent.where(user_id: @user.id).order(created_at: "DESC")

	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "マイページを更新しました"
			redirect_to user_path(@user.id)
		else
			render action: "edit"
		end
	end

	def destroy
	    User.find(params[:id]).destroy
	    flash[:alert] = "退会しました"
	    redirect_to users_path
	end

	def like
	end

	def follow
	end

	def history
		@user = User.find(params[:id])
		@history = History.where(user_id: @user.id)
	end

	def novels
		@user = User.find(params[:id])
		# @novels = Novel.where(user_id: @user)
		@novels = Novel.page(params[:page]).where(user_id:  @user).order(created_at: "DESC")

		# @novels = Novel.where(user_id: @user)
	end

	def novel_contents
		@user = User.find(params[:id])
		@novel_contents = NovelContent.page(params[:page]).where(user_id: @user).order(created_at: "DESC")

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

def user_params
	params.require(:user).permit(:username, :email, :user_about)
end
def correct_user
	@user = User.find(params[:id])
	if current_user.admin  || current_user == @user
	   	render :edit
	else
	   	redirect_to new_user_registration_path
	end
	# if current_user.admin
	#    	render :edit
	# elsif current_user != @user
	#    	redirect_to new_user_registration_path
	# else
	# 	render :edit
	# end
end


