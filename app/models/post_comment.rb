class PostComment < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :post
end
