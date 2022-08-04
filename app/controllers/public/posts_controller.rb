class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
    @types = Type.all
    @alcohols = Alcohol.all
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end

  def post_search
    @model = params[:model]
    if @model == "item"
      @word = params[:word]
      @posts = Post.looks(@model, @word)
    elsif  @model == "type"
      @types = Type.all
      @word = params[:type_id]
      @posts = Post.looks(@model, @word)
      @type_name = Type.find(@word).name
    else
      @alcohols = Alcohol.all
      @word = params[:alcohol_id]
      @posts = Post.looks(@model, @word)
      @alcohol_name = Alcohol.find(@word).name
    end
  end

  private
  def post_params
    params.require(:post).permit(:name, :body, :image, :type_id, :alcohol_id, :customer_id)
  end
end
