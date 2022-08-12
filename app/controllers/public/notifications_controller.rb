class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_customer.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to customers_notifications_path
  end
end
