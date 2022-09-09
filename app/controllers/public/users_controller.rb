class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where(is_hidden: false).page(params[:page]).reverse_order.per(5)
    @groups = @user.groups
    @hidden_posts = @user.posts.where(is_hidden: true).page(params[:page]).reverse_order.per(3)
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def withdraw
     @posts = current_user.posts.all
     current_user.update(is_deleted: true)
     if current_user.is_deleted == true
        @posts.update_all(is_hidden: true)
     end
     reset_session
     redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

end
