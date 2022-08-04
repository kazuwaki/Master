class Public::TimeLinesController < ApplicationController
  def index
    @time_line = TimeLine.new
    @time_lines = TimeLine.all
  end

  def create
    @time_line = current_customer.time_lines.new(time_line_params)
    if @time_line.save
      redirect_to request.referer
    else
      render :index
    end
  end

  def show
    @time_line = TimeLine.find(params[:id])
    @time_line_comment = TimeLineComment.new
  end

  def destroy
    @time_line = TimeLine.find(params[:id])
    @time_line.destroy
    redirect_to request.referer
  end

  private

  def time_line_params
    params.require(:time_line).permit(:title, :body)
  end
end
