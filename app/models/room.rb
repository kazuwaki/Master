# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :customer_rooms
  has_many :chats
  has_many :custoemrs, through: :customer_rooms
end
