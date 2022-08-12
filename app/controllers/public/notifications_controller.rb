class Public::NotificationsController < ApplicationController
  def destroy_all
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to customer_path(current_customer)
  end
end
