class TimeLine < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :time_line_comments, dependent: :destroy

  validates :body, presence: true
  validates :title, presence: true
end
