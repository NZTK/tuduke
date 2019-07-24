class UsersController < ApplicationController
  before_action :user_admin, only: [:index]
  before_action :correct_user, only: [:edit]
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @novels = Novel.where(user_id: @user.id).order(created_at: "desc")
    @novel_contents = NovelContent.where(user_id: @user.id).order(created_at: "DESC")
    @likes = Like.where(user_id: @user.id)
    @follows = User.find(Relationship.where(user_id: @user).order(created_at: "desc").pluck(:follow_id))
    @follower = User.find(Relationship.where(follow_id: @user).order(created_at: "desc").pluck(:user_id))
    @history = History.where(user_id: @user.id)
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
    @user = User.find(params[:id])
    @likes = Like.page(params[:page]).where(user_id: @user.id).order(created_at: "DESC")
  end

  def follow
    @user = User.find(params[:id])
    @follows = User.page(params[:page]).find(Relationship.where(user_id: @user).order(created_at: "desc").pluck(:follow_id))
    @follower = User.page(params[:page]).find(Relationship.where(follow_id: @user).order(created_at: "desc").pluck(:user_id))
  end

  def history
    @user = User.find(params[:id])
    @history = History.where(user_id: @user.id)
  end

  def novels
    @user = User.find(params[:id])

    @novels = Novel.page(params[:page]).where(user_id: @user).order(created_at: "DESC")
  end

  def novel_contents
    @user = User.find(params[:id])
    @novel_contents = NovelContent.page(params[:page]).where(user_id: @user).order(created_at: "DESC")
  end

  def user_restore
    @user = User.only_deleted.find(params[:id]).restore
    flash[:notice] = "#{@user.username}を復元しました"
    redirect_to users_path
  end
end
private
def user_admin
  @users = User.page(params[:page]).with_deleted
  if current_user.admin == false
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
  if current_user.admin || current_user == @user
    render :edit
  else
    flash[:alert] = "権限がありません"
    redirect_to root_path
  end
  # if current_user.admin
  #      render :edit
  # elsif current_user != @user
  #      redirect_to new_user_registration_path
  # else
  #   render :edit
  # end
end
