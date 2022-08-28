# frozen_string_literal: true

class Public::RelationshipsController < ApplicationController
  before_action :ensure_customer, only: [:create, :destroy, :followings, :followers]
  def create
    # ログインユーザーがフォローする
    following = current_customer.follow(@customer)
    following.save
    # フォローした時の通知機能
    @customer.create_notification_follow!(current_customer)
    @customers = Customer.all.order(created_at: :desc).page(params[:customer_page]).per(8)
  end

  def destroy
    # ログインユーザーがフォローを外す
    following = current_customer.unfollow(@customer)
    #following.destroy
    @customers = Customer.all.order(created_at: :desc).page(params[:customer_page]).per(8)
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
