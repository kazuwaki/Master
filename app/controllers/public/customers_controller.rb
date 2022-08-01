class Public::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to my_page_customers_path
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

end
