# frozen_string_literal: true

class Alcohol < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true
end
