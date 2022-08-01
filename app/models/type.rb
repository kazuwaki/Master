class Type < ApplicationRecord
  has_many :posts, dependent: :destroy
end
