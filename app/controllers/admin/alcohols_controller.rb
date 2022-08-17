# frozen_string_literal: true

class Admin::AlcoholsController < ApplicationController
  def index
    @alcohols = Alcohol.all
    @alcohol = Alcohol.new
  end

  def create
    @alcohol = Alcohol.new(alcohol_params)
    if @alcohol.save
      redirect_to request.referer
    else
      @alcohols = Alcohol.all
      render :index
    end
  end

  def edit
    @alcohol = Alcohol.find(params[:id])
  end

  def update
    @alcohol = Alcohol.find(params[:id])
    if @alcohol.update(alcohol_params)
      redirect_to admin_alcohols_path
    else
      render :edit
    end
  end

  private
    def alcohol_params
      params.require(:alcohol).permit(:name)
    end
end
