# frozen_string_literal: true

class Public::TimeLinesController < ApplicationController
  before_action :authenticate_customer!, only: [:create, :destrouy, :show]
  before_action :ensure_guest_user, only: [:create, :destroy]
  before_action :correct_user, only: [:edit, :update]
  def index
    @time_line = TimeLine.new
    @time_lines = TimeLine.all.order(created_at: :desc)
  end

  def create
    @time_line = current_customer.time_lines.new(time_line_params)
    if @time_line.save
      redirect_to request.referer
    else
      @time_lines = TimeLine.all
      render :index
    end
  end

  def show
    @time_line = TimeLine.find(params[:id])
    @time_line_comment = TimeLineComment.new
  end

  private
    def time_line_params
      params.require(:time_line).permit(:title, :body)
    end

    def ensure_guest_user
      @customer = current_customer
      if @customer.name == "guestuser"
        redirect_to posts_path
      end
    end

    def correct_user
      @time_line = TimeLine.find(params[:id])
      @customer = @time_line.customer
      redirect_to(posts_path) unless @customer == current_customer
    end
end
