class Public::PostsController < ApplicationController
 before_action :correct_user, only: [:edit, :status_update, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def index
    @posts = Post.where(is_hidden:"false").page(params[:page]).reverse_order.per(5)
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tagname].split(",")
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tagname).join(',')
  end

  def status_update
    @post = Post.find(params[:post_id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tagname].split(",")
    if @post.update(post_params)
      @old_tags = PostTag.where(post_id: @post.id)
      @old_tags.each do |relation|
        relation.delete
      end
      @post.save_tag(tag_list)
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :is_hidden)
  end

  def tag_params
    params.require(:tag).permit(:tagname)
  end

  def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to posts_path unless @user == current_user
  end
end
