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
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_relationships, source: :customer
  
  validates :name, presence: true

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
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
