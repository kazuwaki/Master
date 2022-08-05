class Admin::TimeLinesController < ApplicationController
  def index
    @time_lines = TimeLine.all
  end

  def show
    @time_line = TimeLine.find(params[:id])
  end

  def destroy
    @time_line = TimeLine.find(params[:id])
    @time_line.destroy
    redirect_to admin_time_lines_path
  end
end
