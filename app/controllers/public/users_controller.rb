class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
  end

  def edit
  end

  def confirm
  end
  
  private
  def user_params
    params.require(:user).permit(:is_deleted, :name, :email)
  end

end
