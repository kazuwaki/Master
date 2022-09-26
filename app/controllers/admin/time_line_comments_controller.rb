# frozen_string_literal: true

class Admin::TimeLineCommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    @time_line_comment = TimeLineComment.find(params[:id])
    @time_line_comment.destroy
    redirect_to admin_time_lines_path
  end
end
