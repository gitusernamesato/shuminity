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
    @posts = Post.where(is_hidden:"false").page(params[:page]).reverse_order.per(5)
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
    @tag_list=@post.tags.pluck(:tagname).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:tagname].split(',')
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
    params.require(:tag).permit(:tagname)
  end
end
