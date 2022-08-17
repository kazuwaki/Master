# frozen_string_literal: true

class TimeLineComment < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :time_line
  
  validates :comment, presence: true
end
