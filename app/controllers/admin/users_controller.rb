class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order.per(5)
    @groups = @user.groups
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @posts = @user.posts.all
    if @user.update(user_params)
        if user_params[:is_deleted] ==  true
          @posts.update_all(is_hidden: true)
        else
          @posts.update_all(is_hidden: false)
        end
      redirect_to admin_user_path(@user)
    else
      redirect_to admin_user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
