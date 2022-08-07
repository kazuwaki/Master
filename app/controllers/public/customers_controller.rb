class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
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
    @post = Post.find(params[:id])
    @customer = @post.customer
    redirect_to(customers_path) unless @customer == current_customer
  end
end
