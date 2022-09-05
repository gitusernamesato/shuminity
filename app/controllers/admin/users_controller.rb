class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order.per(5)
    @groups = @user.groups
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @posts = @user.posts.all
    if @user.update(user_params)
       if @user.is_deleted == true
          # Post.where([user_id: @user.id]).update_all(is_hidden:true)
          @posts.update_all(is_hidden: true)
          redirect_to admin_user_path(@user)
       elsif @user.is_deleted == false
          # @posts.update_all(is_hidden: false) 
          redirect_to admin_users_path
       end
    else
      redirect_to admin_user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
