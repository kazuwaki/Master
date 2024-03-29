# frozen_string_literal: true

class Notification < ApplicationRecord
  default_scope->{order(created_at: :desc)}

  belongs_to :post, optional: true
	belongs_to :post_comment, optional: true
	belongs_to :visiter, class_name: "Customer", foreign_key: "visiter_id", optional: true
	belongs_to :visited, class_name: "Customer", foreign_key: "visited_id", optional: true
end
