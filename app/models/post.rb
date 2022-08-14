class Post < ApplicationRecord
  belongs_to :customer,optional: true
  belongs_to :type
  belongs_to :alcohol
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_customers, through: :likes, source: :customer

  has_many :notifications, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :body, presence: true
  validates :type, presence: true
  validates :alcohol, presence: true
  
  #投稿の公開非公開機能
  enum status: { closed: 0, open: 1 }

  def liked_by?(customer)
    likes.exists?(customer_id: customer.id)
  end

  def self.search_for(model, word)
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
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def create_notification_by(current_customer)
    notification = current_customer.active_notifications.new(
    post_id: id,
    visited_id: customer_id,
    action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_post_comment!(current_customer, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:customer_id).where(post_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_customer, post_comment_id, temp_id['customer_id'])
    end
  # まだ誰もコメントしていない場合は、投稿者に通知を送る
  save_notification_post_comment!(current_customer, post_comment_id, customer_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_customer, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
