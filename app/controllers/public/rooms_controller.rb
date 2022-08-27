class Public::RoomsController < ApplicationController
  def index
    @rooms = current_customer.rooms
  end
end
