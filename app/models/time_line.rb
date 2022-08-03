class TimeLine < ApplicationRecord
  belongs_to :customer
  has_many :time_line_comments, dependent: :destroy
end
