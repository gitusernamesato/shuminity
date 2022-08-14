class Public::PostsController < ApplicationController
  

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def index
    @post = Post.new
    @posts = Post.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
      redirect_to posts_path
    # else
    #   @posts = Post.all
    #   render :index
    # end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
