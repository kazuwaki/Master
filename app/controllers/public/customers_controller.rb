# frozen_string_literal: true

class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def index
    @customers = Customer.all
  end

  def show
    #ユーザーの詳細
    @customer = Customer.find(params[:id])
    #公開している投稿一覧の表示（新着順）
    @posts = @customer.posts.open.order(created_at: :desc).page(params[:page])
    #非公開の投稿一覧の表示（新着順）
    @posted = @customer.posts.closed.order(created_at: :desc).page(params[:page])
    #ユーザーがいいねした投稿の一覧表示
    like_ids = Like.where(customer_id: @customer.id).pluck(:post_id)
    @like_posts = Post.where(id: like_ids).page(params[:page])
    #通知機能の一覧表示
    @notifications = current_customer.passive_notifications.page(params[:page]).per(5)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :introduction, :profile_image)
    end

    def ensure_guest_user
      @customer = Customer.find(params[:id])
      if @customer.name == "guestuser"
        redirect_to customer_path(current_customer)
      end
    end

    def correct_user
      @customer = Customer.find(params[:id])
      @posts = @customer.posts
      redirect_to(customers_path) unless @customer == current_customer
    end
end
