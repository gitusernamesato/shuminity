class Public::GroupsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id

    if @group.save
      @group.users << current_user
      redirect_to groups_path
    else
      render "new"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to group_path(@group)
  end

  def leave
    @group = Group.find(params[:group_id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :introduction, :group_image)
  end

  def correct_user
    @group = Group.find(params[:id])
    @user = @group.owner_id
    redirect_to groups_path unless @user == current_user.id
  end
end
