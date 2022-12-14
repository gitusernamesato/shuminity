class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "Post"
      @posts = Post.looks(params[:search], params[:word]).page(params[:page]).reverse_order.per(5)
      render "public/searches/result"
    else
      @tags = Tag.looks(params[:search], params[:word])
      render "public/searches/result"
    end
  end
end
