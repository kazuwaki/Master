class Public::TimeLineCommentsController < ApplicationController
  def create
    @time_line = TimeLine.find(params[:time_line_id])
    @comment = current_customer.time_line_comments.new(time_line_comment_params)
    @comment.time_line_id = @time_line.id
    unless @comment.save
      render 'error'
    end
    @comment_new = TimeLineComment.new
  end

  def destroy
    @comment = TimeLineComment.find(params[:id])
    @comment.destroy
  end

  private

  def time_line_comment_params
    params.require(:time_line_comment).permit(:comment)
  end
end
