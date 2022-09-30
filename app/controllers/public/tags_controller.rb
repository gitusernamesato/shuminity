class Public::TagsController < ApplicationController

  def show
    @tags = Tag.all
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.where(is_hidden:"false").page(params[:page]).reverse_order.per(5)
  end
end
