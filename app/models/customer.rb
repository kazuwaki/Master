# frozen_string_literal: true

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :time_lines, dependent: :destroy
  has_many :time_line_comments, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_relationships, source: :customer

  has_many :customer_rooms
  has_many :chats
  has_many :rooms, through: :customer_rooms

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
   
  validates :name, presence: true

  def self.guest
    find_or_create_by!(name: "guestuser" ,email: "guest@example.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end


  def follow(other_customer)
    unless self == other_customer
      relationships.find_or_create_by(follow_id: other_customer.id)
    end
  end

  def unfollow(other_customer)
    relationship = relationships.find_by(follow_id: other_customer.id)
    relationship.destroy if relationship
  end

  def following?(other_customer)
    followings.include?(other_customer)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def create_notification_follow!(current_customer)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_customer.id, id, "follow"])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end
end
