class Public::TagsController < ApplicationController
  
  def show
    @tags = Tag.all
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end
end
