class Public::PostsController < ApplicationController
  

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
  end

  def index
    @post = Post.new
    @posts = Post.all
    @tag_list = Tag.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag].split(',')
    if @post.save
     @post.save_tag(tag_list)
     redirect_to posts_path
    else
     @posts = Post.all
     render :index
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @tag_list=@post.tags.pluck(:tag).join(',')
  end
  
  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:tag].split(',')
    if @post.update(post_params)
       @post.save_tag(tag_list)
       redirect_to post_path(@post.id),notice:'投稿完了しました:)'
    else
      render:edit
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  def tag_params
    params.require(:tag).permit(:tag)
  end
end
