class TimeLineComment < ApplicationRecord
  belongs_to :customer
  has_many :time_line_comments, dependent: :destory
end
