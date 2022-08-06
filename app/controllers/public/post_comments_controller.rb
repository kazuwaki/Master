class Public::PostCommentsController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :new]
  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    unless @comment.save
      render 'error'
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
  
  def ensure_guest_user
    @customer = current_customer
    if @customer.name == "guestuser"
      redirect_to posts_path
    end
  end
end
