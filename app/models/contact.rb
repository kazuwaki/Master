# frozen_string_literal: true

class Contact < ApplicationRecord
  enum subject: { other: 0, work: 1, recruit: 2, method: 3 }
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :message, presence: true
end
