# frozen_string_literal: true

class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  def show
    @customer = Customer.find(params[:id])
    rooms = current_customer.customer_rooms.pluck(:room_id)
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)

    # ルームが存在しているかどうか
    unless customer_rooms.nil?
      @room = customer_rooms.room
    else
      #存在していない場合は新しくroomを作成する
      @room = Room.new
      @room.save
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end

  private
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end

    def reject_non_related
      customer = Customer.find(params[:id])
      unless current_customer.following?(customer) && customer.following?(current_customer)
        redirect_to customer_path(customer)
      end
    end
end