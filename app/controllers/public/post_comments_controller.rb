# frozen_string_literal: true

class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment_post = @comment.post
    # コメントの通知機能
    if @comment.save
      @comment_post.create_notification_post_comment!(current_customer, @comment.id)
    else
      render "error"
    end
    @comment_new = PostComment.new
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
end
