class Public::LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    like = current_customer.likes.new(post_id: @post.id)
    like.save
    @post.create_notification_by(current_customer)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_customer.likes.find_by(post_id: @post.id)
    like.destroy
  end
end
