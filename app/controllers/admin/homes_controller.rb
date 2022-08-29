class Admin::HomesController < ApplicationController
  def top
    @posts = Post.page(params[:page]).reverse_order.per(5)
  end
end
