class Public::RelationshipsController < ApplicationController
  before_action :ensure_customer, only: [:create, :destroy, :followings, :followers]
  def create
    following = current_customer.follow(@customer)
    following.save
    @customer.create_notification_follow!(current_customer)
    @customers = Customer.all
  end

  def destroy
    following = current_customer.unfollow(@customer)
    #following.destroy
    @customers = Customer.all
  end

  def followings
    @customers = @customer.followings
  end

  def followers
    @customers = @customer.followers
  end

  private
  def ensure_customer
    @customer = Customer.find(params[:customer_id])
  end
end
