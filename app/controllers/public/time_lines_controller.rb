class Public::TimeLinesController < ApplicationController
  def index
    @time_line = TimeLine.new
    @time_lines = TimeLine.all
    @time_line_comment = TimeLineComment.new
    unless @time_lines = TimeLine.all
      render :index
    end
  end

  def create
    @time_line = current_customer.time_lines.new(time_line_params)
    @time_line.save
  end

  def destroy
    @time_line = TimeLine.find(params[:id])
    @time_line.destroy
  end

  def update

  end

  private

  def time_line_params
    params.require(:time_line).permit(:title, :body)
  end
end
