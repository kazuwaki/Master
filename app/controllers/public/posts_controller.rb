class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :edit]
  before_action :ensure_guest_user, only: [:edit, :new]
  def index
    @posts = Post.all
    @types = Type.all
    @alcohols = Alcohol.all
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @posts = Post.includes(:liked_customers).sort {|a,b| b.liked_customers.size <=> a.liked_customers.size}
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def post_search
    @model = params[:model]
    if @model == "post"
      @word = params[:word]
      @posts = Post.search_for(@model, @word)
    else
      if  @model == "type"
        @types = Type.all
        @word = params[:type_id]
        @posts = Post.search_for(@model, @word)
        @type_name = Type.find(@word).name
      else
        @alcohols = Alcohol.all
        @word = params[:alcohol_id]
        @posts = Post.search_for(@model, @word)
        @alcohol_name = Alcohol.find(@word).name
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :body, :image, :type_id, :alcohol_id, :customer_id)
  end

  def ensure_guest_user
    @customer = current_customer
    if @customer.name == "guestuser"
      redirect_to posts_path
    end
  end
end
