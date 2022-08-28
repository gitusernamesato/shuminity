class Admin::UsersController < ApplicationController
  def show
  end

  def index
    @users = User.all
  end

  def edit
  end
end
