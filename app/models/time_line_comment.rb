class TimeLineComment < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :time_line
end
