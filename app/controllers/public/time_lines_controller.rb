class Public::TimeLinesController < ApplicationController
  def index
    @time_line = TimeLine.new
    @time_lines = TimeLine.all
  end

  def create
    @time_line = TimeLine.new(time_line_params)
    @time_line.save
    redirect_to request.referer
  end

  def destroy
    @time_line = TimeLine.find(params[:id])
    @time_line.destroy
    redirect_to request.referer
  end

  def update

  end

  private

  def time_line_params
    params.require(:time_line).permit(:title, :body, :customer_id)
  end
end
