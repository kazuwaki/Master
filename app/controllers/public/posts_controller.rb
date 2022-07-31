class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
    @types = Type.all
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to posts_path
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:name, :body, :image, :type_id, :alcohol_id)
  end
end
