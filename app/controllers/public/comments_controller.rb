class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
