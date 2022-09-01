# frozen_string_literal: true

class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :edit, :update, :show]
  before_action :ensure_guest_user, only: [:edit, :new, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @posts = Post.open.order(created_at: :desc).page(params[:posts_page]).per(8)
    @types = Type.all
    @alcohols = Alcohol.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      tags = Vision.get_image_data(@post.image)    
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    # いいねが多いtop5を表示する
    @posts = Post.open.includes(:liked_customers).limit(5).sort {|a,b| b.liked_customers.size <=> a.liked_customers.size}
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
    # 検索機能
    @model = params[:model]
    if @model == "post" #モデルがpostの場合
      @word = params[:word]
      if @word == "" #検索ワードが空の場合は一覧画面に遷移する
        redirect_to posts_path
      else
        @posts = Post.open.search_for(@model, @word).page(params[:posts_page]).per(8)
      end
    else
      if  @model == "type" #モデルがTypeの場合
        @types = Type.all
        @type_name = params[:type_id]
        @posts = Post.open.search_for(@model, @type_name).page(params[:posts_page]).per(8)
        @word = Type.find(@type_name).name
      else
        @alcohols = Alcohol.all
        @alcohol_name = params[:alcohol_id]
        @posts = Post.open.search_for(@model, @alcohol_name).page(params[:posts_page]).per(8)
        @word = Alcohol.find(@alcohol_name).name
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:name, :body, :image, :type_id, :alcohol_id, :customer_id, :status)
    end

    def ensure_guest_user
      @customer = current_customer
      if @customer.name == "guestuser"
        redirect_to posts_path
      end
    end

    def correct_user
      @post = Post.find(params[:id])
      @customer = @post.customer
      unless @customer == current_customer
        redirect_to(posts_path)
      end
    end
end
