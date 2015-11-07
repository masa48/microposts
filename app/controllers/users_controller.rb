class UsersController < ApplicationController
  before_action :set_user,only: [:show, :followings, :followers]
  def show
   @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Samle App!"
      redirect_to @user
    else
      render 'new'
    end
  end
    
  def edit
    @user = current_user
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to current_user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "followings"
    @followers = @user.following_users
    render 'followers'
  end
  
  def followers
    @title = "followers"
    @followers = @user.follower_users
  end
  
    
  private
  def user_params
    params.require(:user).permit(:name, :area, :profile, :email, :password, :password_confirmation)
  end
  
  def set_user
   @user = User.find(params[:id])
  end
end
