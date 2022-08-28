class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post)
    else
      redirect_to admin_post_path(@post)
    end
  end
  private
  def post_params
    params.require(:post).permit(:is_hidden)
  end
end
