# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :room

  validates :message, presence:true
end
