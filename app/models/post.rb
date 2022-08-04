class Post < ApplicationRecord
  belongs_to :customer,optional: true
  belongs_to :type
  belongs_to :alcohol
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  def liked_by?(customer)
    likes.exists?(customer_id: customer.id)
  end

  def self.looks(model, word)
    if model == "post"
      @post = Post.where("name LIKE?","%#{word}%")
    elsif model == "type"
      @post = Post.where(type_id: word)
    else
      @post = Post.where(alcohol_id: word)
    end
  end


  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
