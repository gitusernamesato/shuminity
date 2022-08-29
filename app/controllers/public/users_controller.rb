class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where(is_hidden:"false").page(params[:page]).reverse_order.per(5)
    @groups = @user.groups
    @hidden_posts = @user.posts.where(is_hidden:"true").page(params[:page]).reverse_order.per(3)
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
