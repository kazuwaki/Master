class Alcohol < ApplicationRecord
  has_many :posts, dependent: :destroy
end
