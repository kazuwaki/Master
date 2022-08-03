class TimeLine < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :time_line_comments, dependent: :destroy
end
