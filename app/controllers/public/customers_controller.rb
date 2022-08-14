class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.open.order(created_at: :desc)
    @posted = @customer.posts.closed.order(created_at: :desc)
    like_ids = Like.where(customer_id: @customer.id).pluck(:post_id)
    @like_posts = Post.where(id: like_ids)
    @notifications = current_customer.passive_notifications
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

  def destroy_all
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to customer_path(current_customer)
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
